$mappings = @{
    # Videos
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 07.mp4' = 'assets/vid/aurore-casanova-07.mp4'
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 07.mov' = 'assets/vid/aurore-casanova-07.mov'
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 01.mp4' = 'assets/vid/aurore-casanova-01.mp4'
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 01.mov' = 'assets/vid/aurore-casanova-01.mov'
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 06.mp4' = 'assets/vid/aurore-casanova-06.mp4'
    '05 MIGRATION/assets/01 HOME PAGE/AURORE CASANOVA 06.mov' = 'assets/vid/aurore-casanova-06.mov'
    '05 MIGRATION/assets/03 CONTACT/AURORE CASANOVA 07.mov' = 'assets/vid/aurore-casanova-07.mov'
    '05 MIGRATION/assets/03 CONTACT/AURORE CASANOVA 07.mp4' = 'assets/vid/aurore-casanova-07.mp4'

    # Bottles
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/1 AURE/AURE.png' = 'assets/img/aure.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/2 ROSE/ROSE.png' = 'assets/img/rose.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/3 MESNIL SUR OGER/PARCELLAIRE MESNIL.png' = 'assets/img/parcellaire-mesnil.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/4 PUISIEULX CHARDONNAYCHARDONNAY/PARCELLAIRE CHARDO.png' = 'assets/img/parcellaire-chardo.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/5 PINOT NOIR/PARCELLAIRE PINOT.png' = 'assets/img/parcellaire-pinot.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/6 UNION GRAND CRU/ASSEMBLAGE UNION.png' = 'assets/img/assemblage-union.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/7 OGER/CHARDONNAY GRAND CRU.png' = 'assets/img/chardonnay-grand-cru.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/8 COTEAUX MESNIL SUR OGER/COTEAUX MESNIL.png' = 'assets/img/coteaux-mesnil.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/9 COTEAUX PUISIEULX/COTEAUX PUISIEULX.png' = 'assets/img/coteaux-puisieulx.png'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/10 COTEAUX CHAMPVOISY/COTEAUX CHAMPVOISY.png' = 'assets/img/coteaux-champvoisy.png'

    # Logos
    '05 MIGRATION/assets/01 HOME PAGE/LOGOS AURORE/PNG/LOGO COEUR.png' = 'assets/img/logo-coeur.png'
    '05 MIGRATION/assets/01 HOME PAGE/LOGOS AURORE/SVG/LOGO COEUR.svg' = 'assets/img/logo-coeur.svg'

    # Backgrounds
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/6 UNION GRAND CRU/FOND PAGE PRODUIT_ASSEMBLAGE UNION.jpg' = 'assets/img/fond-page-produit_assemblage-union.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/1 AURE/FOND PAGE PRODUIT_AURE.jpg' = 'assets/img/fond-page-produit_aure.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/2 ROSE/FOND PAGE PRODUIT_ROSE.jpg' = 'assets/img/fond-page-produit_rose.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/3 MESNIL SUR OGER/FOND PAGE PRODUIT_MESNIL.jpg' = 'assets/img/fond-page-produit_mesnil.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/7 OGER/FOND PAGE PRODUIT_OGER.jpg' = 'assets/img/fond-page-produit_oger.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/10 COTEAUX CHAMPVOISY/FOND PAGE PRODUIT_COTEAUX CHAMPVOISY.jpg' = 'assets/img/fond-page-produit_coteaux-champvoisy.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/5 PINOT NOIR/FOND PAGE PRODUIT_PINOT NOIR.jpg' = 'assets/img/fond-page-produit_pinot-noir.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/4 PUISIEULX CHARDONNAYCHARDONNAY/FOND PAGE PRODUIT_PUISIEULX.jpg' = 'assets/img/fond-page-produit_puisieulx.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/8 COTEAUX MESNIL SUR OGER/FOND PAGE PRODUIT_COTEAUX MESNIL.jpg' = 'assets/img/fond-page-produit_coteaux-mesnil.jpg'
    '05 MIGRATION/assets/02 VINS & CHAMPAGNES/9 COTEAUX PUISIEULX/FOND PAGE PRODUIT_COTEAUX PUISIEULX.jpg' = 'assets/img/fond-page-produit_coteaux-puisieulx.jpg'
}

# Fonts
$fontMappings = @{
    './09 FONT/HKGrotesk-Regular.ttf' = './assets/fonts/hkgrotesk-regular.ttf'
    './09 FONT/HKGrotesk-Medium.ttf' = './assets/fonts/hkgrotesk-medium.ttf'
    './09 FONT/HKGrotesk-SemiBold.ttf' = './assets/fonts/hkgrotesk-semibold.ttf'
    './09 FONT/HKGrotesk-Bold.ttf' = './assets/fonts/hkgrotesk-bold.ttf'
    '09 FONT/HKGrotesk-Regular.ttf' = 'assets/fonts/hkgrotesk-regular.ttf'
    '09 FONT/HKGrotesk-Medium.ttf' = 'assets/fonts/hkgrotesk-medium.ttf'
    '09 FONT/HKGrotesk-SemiBold.ttf' = 'assets/fonts/hkgrotesk-semibold.ttf'
    '09 FONT/HKGrotesk-Bold.ttf' = 'assets/fonts/hkgrotesk-bold.ttf'
}

Get-ChildItem -Filter *.html | ForEach-Object {
    $file = $_.FullName
    Write-Host "Processing $file..."
    $content = Get-Content $file -Raw
    $newContent = $content
    
    # Apply literal mappings first (SAFEST)
    foreach ($search in $mappings.Keys) {
        $replace = $mappings[$search]
        $newContent = $newContent.Replace($search, $replace)
    }

    foreach ($search in $fontMappings.Keys) {
        $replace = $fontMappings[$search]
        $newContent = $newContent.Replace($search, $replace)
    }

    # Only save if changed
    if ($newContent -ne $content) {
        $newContent | Set-Content $file -NoNewline -Encoding utf8
        Write-Host "Updated."
    } else {
        Write-Host "No changes."
    }
}
