import os
import subprocess
import json
import re
import platform
import io
import requests
import pandas as pd
import iso639

# --- Configuration ---
SHEET_ID = "1Fgue8f8CCHAT9Fxwp3DCrtB4OpYPkuJtDz_wSt2MS9s"
EXCLUDE_LIST = ["_Webpage", "_example", "_Stores", "__Overview", "Sheet1"]
MASTER_JSON_PATH = "assets/translations/localizations.json"
LANG_DIR = "assets/translations/languages/"
GLOBALS_PATH = "lib/globals.dart"
LOADER_PATH = "lib/CodegenLoader.dart"
KEYS_PATH = "lib/locales_keys.dart"

def get_supported_languages():
    """
    Extracts ISO 639-3 language codes from the g_Localizations list in globals.dart.
    """
    print(f"Parsing supported languages from {GLOBALS_PATH}...")
    if not os.path.exists(GLOBALS_PATH):
        print(f"Error: {GLOBALS_PATH} not found.")
        return []
        
    with open(GLOBALS_PATH, "r", encoding="utf8") as f:
        content = f.read()
        match = re.search(r"g_Localizations = \[(.*?)\];", content, re.DOTALL)
        if not match:
            return []
        return re.findall(r"Iso639_3\.(\w+)", match.group(1))

def update_local_json_from_sheets(languages):
    """
    Downloads the Google Sheet as an Excel file and converts tabs into a structured 
    master JSON file, skipping excluded sheets.
    """
    url = f"https://docs.google.com/spreadsheets/d/{SHEET_ID}/export?format=xlsx"
    print("Fetching latest localizations from Google Sheets...")
    try:
        response = requests.get(url)
        response.raise_for_status()
    except Exception as e:
        print(f"Network error: {e}")
        return False

    xl = pd.ExcelFile(io.BytesIO(response.content))
    localizations_all = {}
    
    for sheet_name in sorted(xl.sheet_names):
        if sheet_name in EXCLUDE_LIST or sheet_name.startswith("_"):
            print(f" -> Skipping {sheet_name} (Excluded)")
            continue
            
        print(f" -> Processing: {sheet_name}")
        df = xl.parse(sheet_name)
        if 'key' not in df.columns:
            continue
            
        df = df.dropna(subset=['key'])
        category_data = {}
        
        for _, row in df.iterrows():
            key = str(row['key']).strip()
            if key in ["", "nan"]:
                continue
            
            # Create a nested dictionary for each language code provided
            category_data[key] = {
                lang: (str(row[lang]).strip() if lang in df.columns and pd.notna(row[lang]) else "") 
                for lang in languages
            }
        
        localizations_all[sheet_name] = category_data

    os.makedirs(os.path.dirname(MASTER_JSON_PATH), exist_ok=True)
    with open(MASTER_JSON_PATH, "w", encoding="utf8") as f:
        json.dump(localizations_all, f, ensure_ascii=False, indent=2, sort_keys=True)
    return True

def clear_old_files():
    """
    Wipes the languages directory and deletes previous generated Dart files 
    to prevent stale translation data.
    """
    if os.path.exists(LANG_DIR):
        for f in os.listdir(LANG_DIR):
            os.remove(os.path.join(LANG_DIR, f))
    else:
        os.makedirs(LANG_DIR)
        
    for path in [LOADER_PATH, KEYS_PATH]:
        if os.path.exists(path):
            os.remove(path)

def generate_per_language_jsons(languages):
    """
    Splits the master JSON into individual {iso3}.json files required 
    by the easy_localization generator.
    """
    with open(MASTER_JSON_PATH, "r", encoding="utf8") as f:
        master_dict = json.load(f)
        
    for code in languages:
        localization = {
            cat: {k: v.get(code, "") for k, v in entries.items()} 
            for cat, entries in master_dict.items()
        }
        output_file = os.path.join(LANG_DIR, f"{code}.json")
        with open(output_file, "w", encoding="utf8") as f_out:
            json.dump(localization, f_out, indent=2, sort_keys=True, ensure_ascii=False)

def run_flutter_generation():
    """
    Triggers the easy_localization CLI to build locales_keys.dart and CodegenLoader.dart.
    """
    args = ["dart", "run", "easy_localization:generate", "-S", LANG_DIR, "-O", "./lib", "-o"]
    use_shell = platform.system() == "Windows"
    
    print("Running easy_localization generators...")
    subprocess.call([*args, "locales_keys.dart", "-f", "keys"], shell=use_shell)
    subprocess.call([*args, "CodegenLoader.dart", "-f", "json"], shell=use_shell)

def post_process_codegen_loader(languages):
    """
    Modifies the generated CodegenLoader to support runtime {{PRODUCT}} replacement
    and maps Flutter's ISO 639-1 locales to the project's ISO 639-3 keys.
    """
    if not os.path.exists(LOADER_PATH):
        return

    # Map 3-letter spreadsheet codes to 2-letter Flutter codes using iso639 package
    mapping_dict = {}
    for lang3 in languages:
        try:
            lang1 = iso639.Language.match(lang3).part1
            if lang1:
                mapping_dict[lang1] = lang3
        except Exception:
            print(f"Warning: No ISO 639-1 match found for {lang3}")

    with open(LOADER_PATH, "r", encoding="utf8") as f:
        content = f.read()

    # Strip empty lines or lines with null translations generated by the library
    lines = content.splitlines()
    content = "\n".join([l for l in lines if '": ""' not in l and ": null" not in l])

    # Rewrite class definition to include productName field and constructor
    class_setup = (
        "class CodegenLoader extends AssetLoader {\n"
        "  final String productName;\n"
        "  const CodegenLoader({required this.productName});"
    )
    
    # Injected load method performs dynamic lookup and string replacement
    replacement_logic = f"""
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {{
    final Map<String, String> isoMapping = {json.dumps(mapping_dict, indent=4)};
    final String languageCode = locale.languageCode.toLowerCase();
    final String lookupKey = isoMapping[languageCode] ?? languageCode;
    
    final data = mapLocales[lookupKey];
    if (data == null) return Future.value(null);

    try {{
      String jsonStr = json.encode(data);
      jsonStr = jsonStr.replaceAll('{{{{PRODUCT}}}}', productName);
      return Future.value(json.decode(jsonStr));
    }} catch (e) {{
      return Future.value(data);
    }}
  }}"""

    # Update class header and override the load() method
    content = re.sub(r"class CodegenLoader extends AssetLoader\s*\{.*?const CodegenLoader\(\);", class_setup, content, flags=re.DOTALL)
    content = re.sub(r"@override\s+Future<Map<String, dynamic>\?> load\(String path, Locale locale\) \{.*?\n\s+\}", replacement_logic, content, flags=re.DOTALL)
    
    if "import 'dart:convert';" not in content:
        content = "import 'dart:convert';\n" + content

    with open(LOADER_PATH, "w", encoding="utf8") as f:
        f.write(content)
    print(f"Success: Injected {len(mapping_dict)} language mappings into CodegenLoader.")

def main():
    """
    Main execution pipeline for localization synchronization.
    """
    languages = get_supported_languages()
    if not languages:
        return

    if not update_local_json_from_sheets(languages):
        return

    clear_old_files()
    generate_per_language_jsons(languages)
    run_flutter_generation()
    post_process_codegen_loader(languages)

if __name__ == "__main__":
    main()