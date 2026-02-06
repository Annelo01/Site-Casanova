$files = Get-ChildItem -Filter *.html -Recurse

foreach ($file in $files) {
    $c = Get-Content $file.FullName -Raw -Encoding UTF8
    $changed = $false
    
    # Fix Mesnil Marquee Item
    if ($c -match 'src=""\s+alt="Mesnil"') {
        Write-Host "Fixing Mesnil in $($file.Name)"
        $c = $c -replace 'src=""\s+alt="Mesnil"', 'src="assets/img/parcellaire-mesnil.png" alt="Mesnil"'
        $changed = $true
    }
    
    # Fix Mesnil Sur Oger (just in case)
    if ($c -match 'src=""\s+alt="Mesnil Sur Oger"') {
        Write-Host "Fixing Mesnil Sur Oger in $($file.Name)"
        $c = $c -replace 'src=""\s+alt="Mesnil Sur Oger"', 'src="assets/img/parcellaire-mesnil.png" alt="Mesnil Sur Oger"'
        $changed = $true
    }

    if ($changed) {
        Set-Content -LiteralPath $file.FullName -Value $c -Encoding UTF8
    }
    
    # Final Audit
    $lines = Get-Content $file.FullName
    $i = 0
    foreach ($line in $lines) {
        $i++
        if ($line -match 'src=""') {
            Write-Host "REMAINING EMPTY SRC: $($file.Name):$i -> $line"
        }
    }
}
