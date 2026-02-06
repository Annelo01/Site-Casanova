# Fix Broken Links Smartly V2
# Scans HTML files for asset references.
# Checks if file exists.
# If not, searches for the filename in assets/.
# Updates HTML if found.

$root = Get-Location
$assetsPath = Join-Path $root "assets"
$htmlFiles = Get-ChildItem -Path $root -Filter *.html -Recurse

Write-Host "Indexing assets..."
$assetIndex = @{}
$assetItems = Get-ChildItem -Path $assetsPath -Recurse -File
foreach ($item in $assetItems) {
    if (-not $assetIndex.ContainsKey($item.Name)) {
        $assetIndex[$item.Name] = $item.FullName
    }
}

foreach ($html in $htmlFiles) {
    Write-Host "Checking $($html.Name)..."
    $content = Get-Content $html.FullName -Raw
    $newContent = $content
    $changed = $false
    
    # Matches: (src|href)=["'](assets/[^"']+)["']
    $matches = [regex]::Matches($content, '(src|href)=["''](assets/[^"''#?]+)["'']')
    
    foreach ($match in $matches) {
        $fullMatch = $match.Value
        $relPath = $match.Groups[2].Value
        
        # Safe URL Decode
        $decodedPath = $relPath
        try {
            $decodedPath = [uri]::UnescapeDataString($relPath)
        } catch {
            Write-Host "Warning: Could not decode $relPath"
        }
        
        $fullPath = Join-Path $root $decodedPath
        
        if (-not (Test-Path $fullPath)) {
            Write-Host "  Broken Link: $relPath"
            $filename = Split-Path $decodedPath -Leaf
            
            if ($assetIndex.ContainsKey($filename)) {
                $foundPath = $assetIndex[$filename]
                $newRelPath = [System.IO.Path]::GetRelativePath($root.FullName, $foundPath).Replace("\", "/")
                
                Write-Host "    -> Found at: $newRelPath"
                
                # Replace
                $newContent = $newContent.Replace($relPath, $newRelPath)
                $changed = $true
            } else {
                # Try standardizing the name to find it?
                # e.g. "FILE NAME.JPG" in HTML -> "file-name.jpg" on disk
                # We can try generating standard name for filename
                
                $standardName = $filename.ToLower().Replace(" ", "-").Replace("_", "-")
                while ($standardName.Contains("--")) { $standardName = $standardName.Replace("--", "-") }
                
                if ($assetIndex.ContainsKey($standardName)) {
                     $foundPath = $assetIndex[$standardName]
                     $newRelPath = [System.IO.Path]::GetRelativePath($root.FullName, $foundPath).Replace("\", "/")
                     Write-Host "    -> Found Standardized: $newRelPath"
                     $newContent = $newContent.Replace($relPath, $newRelPath)
                     $changed = $true
                } else {
                     Write-Host "    -> NOT FOUND ($filename)"
                }
            }
        }
    }
    
    if ($changed) {
        Write-Host "  Saving changes..."
        Set-Content -LiteralPath $html.FullName -Value $newContent -Encoding UTF8
    }
}
