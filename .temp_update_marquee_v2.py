import os

files_to_update = [
    "aure.html",
    "rose.html",
    "mesnil.html",
    "puisieulx-chardonnay.html",
    "puisieulx-pinot-noir.html",
    "union-grand-cru.html",
    "coteaux-champvoisy.html"
]

marquee_block = """        <section class="bottle-marquee">
            <div class="marquee-wrapper">
                <div class="marquee-track">
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
                                alt="Puisieulx Chardonnay">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PUISIEULX CHARDONNAY</span>
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
                    <!-- 6. UNION GRAND CRU -->
                    <div class="marquee-item">
                        <a href="union-grand-cru.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/6 UNION GRAND CRU/ASSEMBLAGE UNION.png"
                                alt="Union Grand Cru">
                            <div class="marquee-info">
                                <span class="marquee-sub">ASSEMBLAGE</span>
                                <span class="marquee-title">UNION</span>
                            </div>
                        </a>
                    </div>
                    <!-- 7. OGER -->
                    <div class="marquee-item">
                        <a href="#">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/7 OGER/CHARDONNAY GRAND CRU.png" alt="Oger">
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
                    <!-- 10. COTEAUX CHAMPVOISY -->
                    <div class="marquee-item">
                        <a href="coteaux-champvoisy.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/10 COTEAUX CHAMPVOISY/COTEAUX CHAMPVOISY.png"
                                alt="Coteaux Champvoisy">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">CHAMPVOISY</span>
                            </div>
                        </a>
                    </div>
                </div>
                <!-- Duplicate for seamless scroll -->
                <div class="marquee-track" aria-hidden="true">
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
                                alt="Puisieulx Chardonnay">
                            <div class="marquee-info">
                                <span class="marquee-sub">PARCELLAIRE</span>
                                <span class="marquee-title">PUISIEULX CHARDONNAY</span>
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
                                alt="Union Grand Cru">
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
                    <div class="marquee-item">
                        <a href="coteaux-champvoisy.html">
                            <img src="05 MIGRATION/assets/02 VINS & CHAMPAGNES/10 COTEAUX CHAMPVOISY/COTEAUX CHAMPVOISY.png"
                                alt="Coteaux Champvoisy">
                            <div class="marquee-info">
                                <span class="marquee-sub">COTEAUX CHAMPENOIS</span>
                                <span class="marquee-title">CHAMPVOISY</span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>"""

import re

for filename in files_to_update:
    path = os.path.join(os.getcwd(), filename)
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Regex to find the entire <section class="bottle-marquee"> block
        new_content = re.sub(r'        <section class="bottle-marquee">.*?</section>', marquee_block, content, flags=re.DOTALL)
        
        # Also try <div class="bottle-marquee"> just in case I left some
        new_content = re.sub(r'        <div class="bottle-marquee">.*?</section>', marquee_block, new_content, flags=re.DOTALL)
        # Or closing with </div>
        new_content = re.sub(r'        <section class="bottle-marquee">.*?</div>\n        </section>', marquee_block, new_content, flags=re.DOTALL)

        if new_content != content:
            with open(path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated {filename}")
        else:
            print(f"Could not update {filename} - No match found or already updated.")
    else:
        print(f"File {filename} not found.")
