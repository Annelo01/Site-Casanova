$f1 = "index.html"
if (Test-Path $f1) {
    Write-Host "Restoring $f1..."
    $c1 = Get-Content $f1 -Raw -Encoding UTF8
    $c1 = $c1.Replace('src="" alt="Dictionnaire"', 'src="assets/img/dictionnaire.png" alt="Dictionnaire"')
    $c1 = $c1.Replace('src="" alt="Do It"', 'src="assets/img/do-it.png" alt="Do It"')
    $c1 = $c1.Replace('src="" alt="Flacons"', 'src="assets/img/flacons.png" alt="Flacons"')
    $c1 = $c1.Replace('src="" alt="L''Express"', 'src="assets/img/lexpress.png" alt="L''Express"')
    $c1 = $c1.Replace('src="" alt="Restaurant"', 'src="assets/img/restaurant.png" alt="Restaurant"')
    $c1 = $c1.Replace('src="" alt="Viticole"', 'src="assets/img/viticole.png" alt="Viticole"')
    $c1 = $c1.Replace('src="" alt="Bettane & Desseauve"', 'src="assets/img/bettane.png" alt="Bettane & Desseauve"')
    Set-Content -LiteralPath $f1 -Value $c1 -Encoding UTF8
}

$f2 = "index-en.html"
if (Test-Path $f2) {
    Write-Host "Restoring $f2..."
    $c2 = Get-Content $f2 -Raw -Encoding UTF8
    $c2 = $c2.Replace('src="" alt="Dictionnaire"', 'src="assets/img/dictionnaire.png" alt="Dictionnaire"')
    $c2 = $c2.Replace('src="" alt="Do It"', 'src="assets/img/do-it.png" alt="Do It"')
    $c2 = $c2.Replace('src="" alt="Flacons"', 'src="assets/img/flacons.png" alt="Flacons"')
    $c2 = $c2.Replace('src="" alt="L''Express"', 'src="assets/img/lexpress.png" alt="L''Express"')
    $c2 = $c2.Replace('src="" alt="Restaurant"', 'src="assets/img/restaurant.png" alt="Restaurant"')
    $c2 = $c2.Replace('src="" alt="Viticole"', 'src="assets/img/viticole.png" alt="Viticole"')
    $c2 = $c2.Replace('src="" alt="Bettane & Desseauve"', 'src="assets/img/bettane.png" alt="Bettane & Desseauve"')
    Set-Content -LiteralPath $f2 -Value $c2 -Encoding UTF8
}

Write-Host "Scanning for remaining empty src..."
$files = Get-ChildItem -Filter *.html -Recurse
foreach ($file in $files) {
    $c = Get-Content $file.FullName
    if ($c -match 'src=""') {
        Write-Host "WARNING: Found empty src in $($file.Name)"
    }
}
