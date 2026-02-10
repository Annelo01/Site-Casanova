$files = @(
    'union-grand-cru.html',
    'union-grand-cru-en.html',
    'mesnil.html',
    'mesnil-en.html',
    'puisieulx-pinot-noir.html',
    'puisieulx-pinot-noir-en.html',
    'puisieulx-chardonnay.html',
    'puisieulx-chardonnay-en.html',
    'rose.html',
    'rose-en.html',
    'aure.html',
    'aure-en.html',
    'oger-assemblage.html',
    'oger-assemblage-en.html',
    'coteaux-mesnil.html',
    'coteaux-mesnil-en.html',
    'coteaux-puisieulx.html',
    'coteaux-puisieulx-en.html',
    'coteaux-champvoisy.html',
    'coteaux-champvoisy-en.html'
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # 1. Increase opacity to 0.6 (60%)
        $content = $content -replace '(\.product-info-bg-video\s*\{[^\}]*opacity:\s*)0\.\d+;', '$1 0.6;'
        
        # 2. Speed up video playback rate from 0.1 to 0.5 for smoother playback
        $content = $content -replace '(productInfoVideo\.playbackRate\s*=\s*)0\.1;', '$1 0.5;'
        
        Set-Content $file -Value $content -NoNewline -Encoding UTF8
        Write-Host "Updated: $file (opacity: 0.6, playbackRate: 0.5)"
    } else {
        Write-Host "File not found: $file"
    }
}

Write-Host "`nDone! Videos are now at 60% opacity and play 5x faster for smoother motion."
