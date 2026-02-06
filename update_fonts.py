import os
import re

files_to_update = [
    'aure-en.html', 'aure.html', 'coteaux-champvoisy-en.html', 'coteaux-champvoisy.html',
    'coteaux-mesnil-en.html', 'coteaux-mesnil.html', 'coteaux-puisieulx-en.html',
    'coteaux-puisieulx.html', 'history.html', 'index-en.html', 'mesnil-en.html',
    'mesnil.html', 'oger-assemblage-en.html', 'oger-assemblage.html',
    'puisieulx-chardonnay-en.html', 'puisieulx-chardonnay.html',
    'puisieulx-pinot-noir-en.html', 'puisieulx-pinot-noir.html', 'rose-en.html',
    'rose.html', 'union-grand-cru-en.html', 'union-grand-cru.html', 'vins.html',
    'wines.html'
]

directory = r'c:\Users\DELL\Desktop\Code\Site Casanova'

hanken_google_fonts = """    <!-- Custom Fonts: Hanken Grotesk -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">"""

for filename in files_to_update:
    path = os.path.join(directory, filename)
    if not os.path.exists(path):
        print(f"File not found: {path}")
        continue
    
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Remove preloads
    content = re.sub(r'    <link rel="preload" href="\./09 FONT/HKGrotesk-.*?\.ttf" as="font" type="font/ttf" crossorigin>\n?', '', content)
    content = re.sub(r'    <link rel="preload" href="\./09 FONT/Baskerville\.ttc" as="font" type="font/ttf" crossorigin>\n?', '', content)

    # 2. Add Google Fonts link (replace the "Custom Fonts" comment or old preloads)
    if '<!-- Custom Fonts -->' in content:
        content = content.replace('<!-- Custom Fonts -->', hanken_google_fonts)
    elif '<!-- Custom Fonts: Hanken Grotesk -->' not in content:
        # Fallback if comment is missing, insert before first style tag
        content = content.replace('<style>', hanken_google_fonts + '\n\n    <style>', 1)

    # 3. Remove @font-face block for HK Grotesk and Baskerville
    content = re.sub(r'    <style>\s+@font-face\s+\{[^}]*?font-family:\s*\'HK Grotesk\'[^}]*?\}\s+@font-face\s+\{[^}]*?font-family:\s*\'HK Grotesk\'[^}]*?\}\s+@font-face\s+\{[^}]*?font-family:\s*\'HK Grotesk\'[^}]*?\}\s+@font-face\s+\{[^}]*?font-family:\s*\'HK Grotesk\'[^}]*?\}\s+@font-face\s+\{[^}]*?font-family:\s*\'Baskerville\'[^}]*?\}\s+</style>', '', content, flags=re.DOTALL)
    
    # Try a more flexible regex if the above fails
    content = re.sub(r'<style>\s+@font-face\s+\{[^}]*?font-family:\s*\'HK Grotesk\'.*?</style>', '', content, flags=re.DOTALL)
    content = re.sub(r'<style>\s+@font-face\s+\{[^}]*?font-family:\s*\'Baskerville\'.*?</style>', '', content, flags=re.DOTALL)

    # 4. Update CSS variables
    content = re.sub(r'--font-serif:\s*\'Baskerville\',\s*serif;', '--font-serif: \'Hanken Grotesk\', sans-serif;', content)
    content = re.sub(r'--font-sans:\s*\'HK Grotesk\',\s*sans-serif;', '--font-sans: \'Hanken Grotesk\', sans-serif;', content)
    content = re.sub(r'--font-nav:\s*\'HK Grotesk\',\s*sans-serif;', '--font-nav: \'Hanken Grotesk\', sans-serif;', content)
    
    # 5. Clean up extra comments if any
    content = content.replace('<!-- Preload Fonts to prevent layout shift (zoom/dezoom effect) -->', '')

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated {filename}")
