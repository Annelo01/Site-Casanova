import glob
import re
import os

def update_footer():
    files = glob.glob("*.html")
    # Regex to match the image and the h2, handling optional whitespace and attributes order
    # Note: we assume the img comes before the h2 immediately or with some whitespace
    pattern = re.compile(r'(<img\s+[^>]*src=["\']assets/img/logo-coeur\.png["\'][^>]*>)\s*(<h2\s+class=["\']footer-brand-name["\'][^>]*>.*?</h2>)', re.DOTALL | re.IGNORECASE)
    
    # Alternate pattern in case the image class is different or order is different? 
    # Based on file views, it seems consistent: img then h2.
    
    new_logo_tag = '<img src="assets/img/logo svg footpage.svg" alt="Aurore Casanova Champagne" class="footer-heart-logo">'
    
    count = 0
    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        new_content = pattern.sub(new_logo_tag, content)
        
        # Also handle cases where the h2 might not be immediately there or already removed (for index.html if script partially ran)
        # But we want to target the pair.
        
        # If the file was already updated (contains new logo), skip or check if h2 is still there?
        if "logo svg footpage.svg" in new_content:
             # Check if H2 is still there (orphan H2?)
             # The regex removes both, so if it matched, H2 is gone.
             pass
        
        if content != new_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated {file_path}")
            count += 1
        else:
            # Check if it needs update but regex failed
            if "logo-coeur.png" in content:
                print(f"WARNING: Found logo-coeur.png in {file_path} but regex didn't match!")
            elif "logo svg footpage.svg" in content:
                print(f"Already updated {file_path}")

    print(f"Total files updated: {count}")

if __name__ == "__main__":
    update_footer()
