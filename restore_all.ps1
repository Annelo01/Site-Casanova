$files = @("index.html", "index-en.html", "history.html")

foreach ($f in $files) {
    if (Test-Path $f) {
        Write-Host "Restoring $f..."
        $c = Get-Content $f -Raw -Encoding UTF8
        # Using exact search/replace to avoid accidental overwrites
        $c = $c.Replace('src="" alt="Dictionnaire"', 'src="assets/img/dictionnaire.png" alt="Dictionnaire"')
        $c = $c.Replace('src="" alt="Do It"', 'src="assets/img/do-it.png" alt="Do It"')
        $c = $c.Replace('src="" alt="Flacons"', 'src="assets/img/flacons.png" alt="Flacons"')
        $c = $c.Replace('src="" alt="L''Express"', 'src="assets/img/lexpress.png" alt="L''Express"')
        $c = $c.Replace('src="" alt="Restaurant"', 'src="assets/img/restaurant.png" alt="Restaurant"')
        $c = $c.Replace('src="" alt="Viticole"', 'src="assets/img/viticole.png" alt="Viticole"')
        $c = $c.Replace('src="" alt="Bettane & Desseauve"', 'src="assets/img/bettane.png" alt="Bettane & Desseauve"')
        Set-Content -LiteralPath $f -Value $c -Encoding UTF8
    }
}

Write-Host "Scanning for remaining empty src..."
$allFiles = Get-ChildItem -Filter *.html -Recurse
foreach ($file in $allFiles) {
    $c = Get-Content $file.FullName
    $lineNum = 0
    foreach ($line in $c) {
        $lineNum++
        if ($line -match 'src=""') {
            Write-Host "WARNING: Empty src in $($file.Name) at line $lineNum"
        }
    }
}
