# Restore Press Logos and Fix src=""
# The previous script wiped broken links due to missing API.
# This script manually restores the known press logos and checks for other empty src attributes.

$files = @("index.html", "index-en.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Restoring $file..."
        $content = Get-Content $file -Raw
        
        # Specific replacements relying on alt tags which are preserved
        $content = $content.Replace('src="" alt="Dictionnaire"', 'src="assets/img/dictionnaire.png" alt="Dictionnaire"')
        $content = $content.Replace('src="" alt="Do It"', 'src="assets/img/do-it.png" alt="Do It"')
        $content = $content.Replace('src="" alt="Flacons"', 'src="assets/img/flacons.png" alt="Flacons"')
        $content = $content.Replace('src="" alt="L''Express"', 'src="assets/img/lexpress.png" alt="L''Express"')
        $content = $content.Replace('src="" alt="Restaurant"', 'src="assets/img/restaurant.png" alt="Restaurant"')
        $content = $content.Replace('src="" alt="Viticole"', 'src="assets/img/viticole.png" alt="Viticole"')
        $content = $content.Replace('src="" alt="Bettane & Desseauve"', 'src="assets/img/bettane.png" alt="Bettane & Desseauve"')
        
        Set-Content -LiteralPath $file -Value $content -Encoding UTF8
    }
}

# Scan for any remaining empty sources
Write-Host "Scanning for other empty src attributes..."
$allHtml = Get-ChildItem -Filter *.html -Recurse
foreach ($html in $allHtml) {
    $c = Get-Content $html.FullName
    $lineNum = 0
    foreach ($line in $c) {
        $lineNum++
        if ($line -match 'src=""') {
            Write-Host "WARNING: Empty src found in $($html.Name) at line $lineNum: $line"
        }
    }
}
