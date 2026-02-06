import os
import re

def fix_html_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern: } followed by optional whitespace, then <style> without </style> before it.
    # Specifically looking for the error pattern found:
    # }
    # 
    # <style>
    # :root {
    
    pattern = r'}\s*\n\s*<style>\s*\n\s*:root\s*{'
    replacement = r'}\n\n        :root {'
    
    new_content = re.sub(pattern, replacement, content)
    
    # Also fix the --text-grey if it is #000000
    new_content = new_content.replace('--text-grey: #000000;', '--text-grey: #666666;')
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

files = [f for f in os.listdir('.') if f.endswith('.html')]
fixed_count = 0
for file in files:
    if fix_html_file(file):
        print(f"Fixed {file}")
        fixed_count += 1

print(f"Total files fixed: {fixed_count}")
