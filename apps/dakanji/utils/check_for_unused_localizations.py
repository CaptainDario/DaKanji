import os
import json
import re

def get_all_localization_keys():
    """Extracts a flat list of 'category.key' strings from the JSON."""
    json_path = "assets/translations/localizations.json"
    if not os.path.exists(json_path):
        print(f"Error: {json_path} not found.")
        return []

    with open(json_path, "r", encoding="utf8") as f:
        data = json.load(f)
    
    keys = []
    for category, entries in data.items():
        for key in entries.keys():
            # easy_localization usually uses Category.Key or category.key
            keys.append(f"{category}.{key}")
    return keys

def find_unused_keys():
    # 1. Get keys from JSON
    all_keys = get_all_localization_keys()
    if not all_keys:
        return

    # We'll keep track of which ones we find
    unused_keys = set(all_keys)
    
    # 2. Scan all Dart files in /lib
    lib_path = os.path.join(os.getcwd(), "lib")
    
    print(f"Scanning {len(all_keys)} keys across Dart files in /lib...")

    for root, dirs, files in os.walk(lib_path):
        for file in files:
            if file.endswith(".dart"):
                file_path = os.path.join(root, file)
                
                # Skip the generated files themselves, otherwise they'll always be 'used'
                if file in ["locales_keys.dart", "CodegenLoader.dart"]:
                    continue

                with open(file_path, "r", encoding="utf8") as f:
                    content = f.read()
                    
                    # Check for each unused key in the content
                    # We use a copy of the set to allow removal while iterating
                    for key in list(unused_keys):
                        # We look for the key part. 
                        # Example: If key is "Settings.title", we look for "Settings.title" or "settings_title"
                        # depending on how easy_localization generates your keys.
                        key_parts = key.split('.')
                        search_term = key_parts[-1] # Look for the specific key name
                        
                        if search_term in content:
                            unused_keys.remove(key)

    # 3. Report results
    print("\n" + "="*30)
    if not unused_keys:
        print("CONGRATS! All localization keys are currently in use.")
    else:
        print(f"FOUND {len(unused_keys)} UNUSED KEYS:")
        print("="*30)
        # Group by category for easier reading
        current_cat = ""
        for key in sorted(list(unused_keys)):
            cat = key.split('.')[0]
            if cat != current_cat:
                print(f"\n[{cat}]")
                current_cat = cat
            print(f"  - {key.split('.')[-1]}")
            
    print("\n" + "="*30)
    print("Note: Automated scripts might miss keys used via dynamic string interpolation.")

if __name__ == "__main__":
    find_unused_keys()