$files = Get-ChildItem -Filter *.html -Recurse
foreach ($file in $files) {
    $content = Get-Content $file.FullName
    $lineNum = 0
    foreach ($line in $content) {
        $lineNum++
        if ($line -match 'src=""') {
            # Try to extract alt tag for context
            $alt = "NO ALT"
            if ($line -match 'alt="([^"]+)"') {
                $alt = $matches[1]
            }
            Write-Host "$($file.Name):$lineNum [Alt: $alt] -> $line"
        }
    }
}
