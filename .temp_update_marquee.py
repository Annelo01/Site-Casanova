#!/usr/bin/env python3
"""
Script to update marquee links in all HTML files
"""

import re

# Liste des fichiers à mettre à jour
files = [
    'rose.html',
    'mesnil.html',
    'puisieulx-chardonnay.html',
    'puisieulx-pinot-noir.html',
    'union-grand-cru.html',
    'coteaux-champvoisy.html'
]

# Template pour chaque item du marquee avec liens
marquee_template = '''                <div class="marquee-track">
                    <!-- 1. AURE -->
                    <div class="marquee-item">
                        <a href="aure.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/1 AURE/AURE.png" alt="Aure">
                            <div class="marquee-info">
                                <span class="marquee-sub">CUVÉE</span>
                                <span class="marquee-title">AURE</span>
                            </div>
                        </a>
                    </div>
                    <!-- 2. ROSE -->
                    <div class="marquee-item">
                        <a href="rose.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/2 ROSE/ROSE.png" alt="Rose">
                            <div class="marquee-info">
                                <span class="marquee-sub">CUVÉE</span>
                                <span class="marquee-title">ROSE</span>
                            </div>
                        </a>
                    </div>
                    <!-- 3. MESNIL SUR OGER -->
                    <div class="marquee-item">
                        <a href="mesnil.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/3 MESNIL SUR OGER/PARCELLAIRE MESNIL.png"
                                alt="Mesnil">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">MESNIL SUR OGER</span>
                            </div>
                        </a>
                    </div>
                    <!-- 4. PUISIEULX CHARDONNAY -->
                    <div class="marquee-item">
                        <a href="puisieulx-chardonnay.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/4 PUISIEULX CHARDONNAYCHARDONNAY/PARCELLAIRE CHARDO.png"
                                alt="Puisieulx">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PUISIEULX</span>
                            </div>
                        </a>
                    </div>
                    <!-- 5. PINOT NOIR -->
                    <div class="marquee-item">
                        <a href="puisieulx-pinot-noir.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/5 PINOT NOIR/PARCELLAIRE PINOT.png"
                                alt="Pinot Noir">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PINOT NOIR</span>
                            </div>
                        </a>
                    </div>
                    <!-- 6. UNION -->
                    <div class="marquee-item">
                        <a href="union-grand-cru.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/6 UNION GRAND CRU/ASSEMBLAGE UNION.png"
                                alt="Union">
                            <div class="marquee-info">
                                <span class="marquee-sub">ASSEMBLAGE</span>
                                <span class="marquee-title">UNION</span>
                            </div>
                        </a>
                    </div>
                    <!-- 7. OGER -->
                    <div class="marquee-item">
                        <a href="#">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/7 OGER/CHARDONNAY GRAND CRU.png"
                                alt="Oger">
                            <div class="marquee-info">
                                <span class="marquee-sub">GRAND CRU</span>
                                <span class="marquee-title">OGER</span>
                            </div>
                        </a>
                    </div>
                    <!-- 8. COTEAUX MESNIL -->
                    <div class="marquee-item">
                        <a href="#">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/8 COTEAUX MESNIL SUR OGER/COTEAUX MESNIL.png"
                                alt="Coteaux Mesnil">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">MESNIL</span>
                            </div>
                        </a>
                    </div>
                    <!-- 9. COTEAUX PUISIEULX -->
                    <div class="marquee-item">
                        <a href="coteaux-champvoisy.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/9 COTEAUX PUISIEULX/COTEAUX PUISIEULX.png"
                                alt="Coteaux Puisieulx">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">PUISIEULX</span>
                            </div>
                        </a>
                    </div>

                    <!-- REPEAT FOR LOOP -->
                    <div class="marquee-item">
                        <a href="aure.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/1 AURE/AURE.png" alt="Aure">
                            <div class="marquee-info">
                                <span class="marquee-sub">CUVÉE</span>
                                <span class="marquee-title">AURE</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="rose.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/2 ROSE/ROSE.png" alt="Rose">
                            <div class="marquee-info">
                                <span class="marquee-sub">CUVÉE</span>
                                <span class="marquee-title">ROSE</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="mesnil.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/3 MESNIL SUR OGER/PARCELLAIRE MESNIL.png"
                                alt="Mesnil">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">MESNIL SUR OGER</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="puisieulx-chardonnay.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/4 PUISIEULX CHARDONNAYCHARDONNAY/PARCELLAIRE CHARDO.png"
                                alt="Puisieulx">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PUISIEULX</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="puisieulx-pinot-noir.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/5 PINOT NOIR/PARCELLAIRE PINOT.png"
                                alt="Pinot Noir">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PINOT NOIR</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="union-grand-cru.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/6 UNION GRAND CRU/ASSEMBLAGE UNION.png"
                                alt="Union">
                            <div class="marquee-info">
                                <span class="marquee-sub">ASSEMBLAGE</span>
                                <span class="marquee-title">UNION</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="#">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/7 OGER/CHARDONNAY GRAND CRU.png"
                                alt="Oger">
                            <div class="marquee-info">
                                <span class="marquee-sub">GRAND CRU</span>
                                <span class="marquee-title">OGER</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="#">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/8 COTEAUX MESNIL SUR OGER/COTEAUX MESNIL.png"
                                alt="Coteaux Mesnil">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">MESNIL</span>
                            </div>
                        </a>
                    </div>
                    <div class="marquee-item">
                        <a href="coteaux-champvoisy.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/9 COTEAUX PUISIEULX/COTEAUX PUISIEULX.png"
                                alt="Coteaux Puisieulx">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">PUISIEULX</span>
                            </div>
                        </a>
                    </div>
                </div>'''

for filename in files:
    print(f"Processing {filename}...")
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remplacer le contenu entre <div class="marquee-track"> et </div> (fin du track)
    pattern = r'<div class="marquee-track">.*?</div>\s*</div>\s*</section>'
    replacement = marquee_template + '\r\n            </div>\r\n        </section>'
    
    new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"✓ {filename} updated")

print("\n✅ All files updated successfully!")
