import os

files = ["index.html", "index-en.html"]

replacements = [
    ('src="" alt="Dictionnaire"', 'src="assets/img/dictionnaire.png" alt="Dictionnaire"'),
    ('src="" alt="Do It"', 'src="assets/img/do-it.png" alt="Do It"'),
    ('src="" alt="Flacons"', 'src="assets/img/flacons.png" alt="Flacons"'),
    ('src="" alt="L\'Express"', 'src="assets/img/lexpress.png" alt="L\'Express"'),
    ('src="" alt="Restaurant"', 'src="assets/img/restaurant.png" alt="Restaurant"'),
    ('src="" alt="Viticole"', 'src="assets/img/viticole.png" alt="Viticole"'),
    ('src="" alt="Bettane & Desseauve"', 'src="assets/img/bettane.png" alt="Bettane & Desseauve"'),
]

for f in files:
    if os.path.exists(f):
        print(f"Restoring {f}...")
        with open(f, 'r', encoding='utf-8') as file:
            content = file.read()
        
        for old, new in replacements:
            if old in content:
                print(f"  Fixing {old} -> {new}")
                content = content.replace(old, new)
        
        with open(f, 'w', encoding='utf-8') as file:
            file.write(content)

print("-" * 20)
print("Scanning for remaining empty src attributes...")
for root, dirs, filenames in os.walk("."):
    if ".git" in dirs:
        dirs.remove(".git")
        
    for filename in filenames:
        if filename.endswith(".html"):
            path = os.path.join(root, filename)
            with open(path, 'r', encoding='utf-8') as file:
                for i, line in enumerate(file):
                    if 'src=""' in line:
                        print(f"WARNING: Empty src in {path}:{i+1} -> {line.strip()}")
