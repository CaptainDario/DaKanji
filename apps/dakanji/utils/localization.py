import os
import subprocess
import json
import re
import platform
import io
import requests
import pandas as pd

def update_local_json_from_sheets(languages):
    sheet_id = "1Fgue8f8CCHAT9Fxwp3DCrtB4OpYPkuJtDz_wSt2MS9s"
    export_url = f"https://docs.google.com/spreadsheets/d/{sheet_id}/export?format=xlsx"
    
    # YOUR NEW EXCLUDE LIST
    exclude_list = ["_Webpage", "_example", "_Stores", "Overview", "Sheet1"]
    
    print("Fetching latest localizations from Google Sheets...")
    try:
        response = requests.get(export_url)
        response.raise_for_status()
    except Exception as e:
        print(f"Error: Could not download spreadsheet: {e}")
        return False

    excel_data = io.BytesIO(response.content)
    xl = pd.ExcelFile(excel_data)
    localizations_all = {}

    # Sort sheet names alphabetically before processing 
    # (This ensures the JSON output order is consistent)
    sorted_sheet_names = sorted(xl.sheet_names)

    for sheet_name in sorted_sheet_names:
        # Check against exclude list
        if sheet_name in exclude_list or sheet_name.startswith("_"):
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
            if key == "" or key == "nan": continue
            
            translations = {}
            for lang in languages:
                if lang in df.columns:
                    val = row[lang]
                    translations[lang] = str(val).strip() if pd.notna(val) else ""
                else:
                    translations[lang] = ""
            
            category_data[key] = translations
        
        localizations_all[sheet_name] = category_data

    output_path = "assets/translations/localizations.json"
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", encoding="utf8") as f:
        # sort_keys=True makes the resulting JSON much easier to read/debug
        json.dump(localizations_all, f, ensure_ascii=False, indent=2, sort_keys=True)
    
    print(f"Successfully updated {output_path}")
    return True

def main():
    # 1. Parse supported languages from globals.dart first
    print("Parsing supported languages from globals.dart...")
    with open("lib/globals.dart", "r", encoding="utf8") as f_globals:
        globals_content = f_globals.read()
        # Regex to find the list content and then the specific ISO codes
        list_match = re.search(r"g_Localizations = \[(.*?)\];", globals_content, re.DOTALL)
        if not list_match:
            print("Error: Could not find g_Localizations in globals.dart")
            return
            
        languages = re.findall(r"Iso639_3\.(\w+)", list_match.group(1))
        print(f"Found following supported languages: {languages}")

    # 2. Download from Google Sheets using those languages
    if not update_local_json_from_sheets(languages):
        return

    # 3. Cleanup old files
    lang_dir = "assets/translations/languages/"
    if os.path.exists(lang_dir):
        for f in os.listdir(lang_dir):
            os.remove(os.path.join(lang_dir, f))
    else:
        os.makedirs(lang_dir)

    for f_path in ["lib/CodegenLoader.dart", "lib/locales_keys.dart"]:
        if os.path.exists(f_path):
            os.remove(f_path)

    # 4. Create separate json files for every language
    with open("assets/translations/localizations.json", "r", encoding="utf8") as f:
        jason_dict = json.load(f)
        
        for code in languages:
            localization = {}
            for category, category_children in jason_dict.items():
                localization[category] = {}
                for category_entry, trans_dict in category_children.items():
                    # Extract the specific language code from the nested dict
                    localization[category][category_entry] = trans_dict.get(code, "")
            
            js = json.dumps(localization, indent=2, sort_keys=True)
            with open(f"assets/translations/languages/{code}.json", "w", encoding="utf8") as f_out:
                f_out.write(js)

    # 5. Run Flutter commands
    shared_args = ["dart", "run", "easy_localization:generate", "-S", "assets/translations/languages/", "-O", "./lib", "-o"]
    use_shell = True if platform.system() == "Windows" else False
    
    print("Generating localization keys...")
    subprocess.call([*shared_args, "locales_keys.dart", "-f", "keys"], shell=use_shell)
    print("Generating CodegenLoader...")
    subprocess.call([*shared_args, "CodegenLoader.dart", "-f", "json"], shell=use_shell)

    # 6. Post-process CodegenLoader to remove empty strings
    loader_path = os.path.join("lib", "CodegenLoader.dart")
    if os.path.exists(loader_path):
        with open(loader_path, "r", encoding="utf8") as file:
            lines = file.readlines()
        
        # Keep lines that don't have empty translations or nulls
        filtered_lines = [line for line in lines if '": ""' not in line and ": null" not in line]

        with open(loader_path, "w", encoding="utf8") as file:
            file.writelines(filtered_lines)
        print("Cleaned up empty translations from CodegenLoader.dart")

if __name__ == "__main__":
    main()