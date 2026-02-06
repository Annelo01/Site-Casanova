import os
import re

# Paths
ROOT_DIR = os.getcwd()
ASSETS_IMG = os.path.join(ROOT_DIR, 'assets', 'img')
ASSETS_VID = os.path.join(ROOT_DIR, 'assets', 'vid')
ASSETS_FONTS = os.path.join(ROOT_DIR, 'assets', 'fonts')

# Mappings (regex pattern -> replacement function)
# We need to find the file in the new location.

def find_file(filename):
    # Search in img, vid, fonts
    # Case insensitive search
    for directory in [ASSETS_IMG, ASSETS_VID, ASSETS_FONTS]:
        if not os.path.exists(directory):
            continue
        for f in os.listdir(directory):
            if f.lower() == filename.lower():
                # return relative path from root
                rel_dir = os.path.relpath(directory, ROOT_DIR).replace('\\', '/')
                return f"{rel_dir}/{f}"
    return None

def replace_match(match):
    full_path = match.group(0)
    # Extract filename
    filename = os.path.basename(full_path)
    
    # Special case depending on extension?
    # No, just look for the file in the new assets folders.
    
    new_path = find_file(filename)
    if new_path:
        print(f"Replacing '{full_path}' with './{new_path}'")
        return f"./{new_path}"
    else:
        print(f"WARNING: File not found for '{full_path}' - keeping original but it might be broken")
        return full_path

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match old paths
    # Matches: "05 MIGRATION/..." or "./05 MIGRATION/..." or "09 FONT/..."
    # We want to capture the whole path string, usually inside src="..." or url('...')
    # But let's just match the path starting with 05 MIGRATION or 09 FONT up to a quote or parenthesis
    
    # Regex explanations:
    # ([\.\/]*?05 MIGRATION\/[^\s\"\'\(\)]+)
    # Matches optional ./ or / followed by 05 MIGRATION/ followed by anything not whitespace, quote, or paren.
    
    pattern_migration = re.compile(r'([\.\/]*?05 MIGRATION\/[^\s\"\'\(\)<>]+)', re.IGNORECASE)
    pattern_font = re.compile(r'([\.\/]*?09 FONT\/[^\s\"\'\(\)<>]+)', re.IGNORECASE)
    
    new_content = content
    
    def replacement_wrapper(match):
        return replace_match(match)

    new_content = pattern_migration.sub(replacement_wrapper, new_content)
    new_content = pattern_font.sub(replacement_wrapper, new_content)
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")
    else:
        print(f"No changes in {filepath}")

def main():
    print("Starting patch process...")
    for root, dirs, files in os.walk(ROOT_DIR):
        # Skip .git etc
        if '.git' in dirs:
            dirs.remove('.git')
        if 'node_modules' in dirs:
            dirs.remove('node_modules')
            
        for file in files:
            if file.lower().endswith('.html'):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
