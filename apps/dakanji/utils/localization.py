import os
import subprocess
import json
import re
import platform
import io
import requests
import pandas as pd

# --- Configuration ---
SHEET_ID = "1Fgue8f8CCHAT9Fxwp3DCrtB4OpYPkuJtDz_wSt2MS9s"
EXCLUDE_LIST = ["_Webpage", "_example", "_Stores", "__Overview", "Sheet1"]
MASTER_JSON_PATH = "assets/translations/localizations.json"
LANG_DIR = "assets/translations/languages/"
GLOBALS_PATH = "lib/globals.dart"
LOADER_PATH = "lib/CodegenLoader.dart"
KEYS_PATH = "lib/locales_keys.dart"

def get_supported_languages():
    """Parses supported languages from globals.dart using regex."""
    print(f"Parsing supported languages from {GLOBALS_PATH}...")
    if not os.path.exists(GLOBALS_PATH):
        print(f"Error: {GLOBALS_PATH} not found.")
        return []

    with open(GLOBALS_PATH, "r", encoding="utf8") as f:
        content = f.read()
        match = re.search(r"g_Localizations = \[(.*?)\];", content, re.DOTALL)
        if not match:
            print("Error: Could not find g_Localizations in globals.dart")
            return []
            
        return re.findall(r"Iso639_3\.(\w+)", match.group(1))

def update_local_json_from_sheets(languages):
    """Downloads the Excel export from Google Sheets and builds the master JSON."""
    url = f"https://docs.google.com/spreadsheets/d/{SHEET_ID}/export?format=xlsx"
    
    print("Fetching latest localizations from Google Sheets...")
    try:
        response = requests.get(url)
        response.raise_for_status()
    except Exception as e:
        print(f"Error: Could not download spreadsheet: {e}")
        return False

    xl = pd.ExcelFile(io.BytesIO(response.content))
    localizations_all = {}

    for sheet_name in sorted(xl.sheet_names):
        if sheet_name in EXCLUDE_LIST or sheet_name.startswith("_"):
            print(f" -> Skipping {sheet_name} (Excluded)")
            continue
            
        print(f" -> Processing sheet: {sheet_name}")
        df = xl.parse(sheet_name)
        if 'key' not in df.columns:
            continue
            
        df = df.dropna(subset=['key'])
        category_data = {}

        for _, row in df.iterrows():
            key = str(row['key']).strip()
            if key in ["", "nan"]: continue
            
            translations = {}
            for lang in languages:
                val = row[lang] if lang in df.columns else ""
                translations[lang] = str(val).strip() if pd.notna(val) else ""
            
            category_data[key] = translations
        
        localizations_all[sheet_name] = category_data

    os.makedirs(os.path.dirname(MASTER_JSON_PATH), exist_ok=True)
    with open(MASTER_JSON_PATH, "w", encoding="utf8") as f:
        json.dump(localizations_all, f, ensure_ascii=False, indent=2, sort_keys=True)
    
    print(f"Successfully updated {MASTER_JSON_PATH}")
    return True

def clear_old_files():
    """Removes old language JSONs and generated Dart files."""
    if os.path.exists(LANG_DIR):
        for f in os.listdir(LANG_DIR):
            os.remove(os.path.join(LANG_DIR, f))
    else:
        os.makedirs(LANG_DIR)

    for path in [LOADER_PATH, KEYS_PATH]:
        if os.path.exists(path):
            os.remove(path)

def generate_per_language_jsons(languages):
    """Splits the master JSON into separate files for easy_localization to ingest."""
    with open(MASTER_JSON_PATH, "r", encoding="utf8") as f:
        master_dict = json.load(f)
        
        for code in languages:
            localization = {}
            for category, entries in master_dict.items():
                localization[category] = {k: v.get(code, "") for k, v in entries.items()}
            
            output_file = os.path.join(LANG_DIR, f"{code}.json")
            with open(output_file, "w", encoding="utf8") as f_out:
                json.dump(localization, f_out, indent=2, sort_keys=True, ensure_ascii=False)

def run_flutter_generation():
    """Executes the easy_localization generator commands."""
    args = ["dart", "run", "easy_localization:generate", "-S", LANG_DIR, "-O", "./lib", "-o"]
    use_shell = platform.system() == "Windows"
    
    print("Generating localization keys...")
    subprocess.call([*args, "locales_keys.dart", "-f", "keys"], shell=use_shell)
    print("Generating CodegenLoader...")
    subprocess.call([*args, "CodegenLoader.dart", "-f", "json"], shell=use_shell)

def post_process_codegen_loader():
    """Injects {{PRODUCT}} replacement logic and removes empty translation lines."""
    if not os.path.exists(LOADER_PATH):
        return

    with open(LOADER_PATH, "r", encoding="utf8") as f:
        content = f.read()

    # 1. Filter out empty/null translation lines
    lines = content.splitlines()
    filtered_lines = [l for l in lines if '": ""' not in l and ": null" not in l]
    content = "\n".join(filtered_lines)

    # 2. Define the runtime replacement logic
    replacement_logic = """
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    var data = mapLocales[locale.toString()];
    if (data == null) return Future.value(null);

    String jsonStr = json.encode(data);
    jsonStr = jsonStr.replaceAll('{{PRODUCT}}', g_RuntimeProductName);
    return Future.value(json.decode(jsonStr));
  }"""

    # 3. Use regex to replace the auto-generated 'load' method
    content = re.sub(
        r"@override\s+Future<Map<String, dynamic>\?> load\(String path, Locale locale\) \{.*?\n\s+\}",
        replacement_logic,
        content,
        flags=re.DOTALL
    )

    # 4. Add missing import for json encoding/decoding
    if "import 'dart:convert';" not in content:
        content = "import 'dart:convert';\n" + content

    with open(LOADER_PATH, "w", encoding="utf8") as f:
        f.write(content)
    print(f"Post-processed {LOADER_PATH} (Empties removed & {{PRODUCT}} injected).")

def main():
    # 1. Setup
    languages = get_supported_languages()
    if not languages: return

    # 2. Fetch Data
    if not update_local_json_from_sheets(languages): return

    # 3. Cleanup & Split
    clear_old_files()
    generate_per_language_jsons(languages)

    # 4. Generate & Patch
    run_flutter_generation()
    post_process_codegen_loader()

if __name__ == "__main__":
    main()