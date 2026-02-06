# Fix Broken Links Smartly
# Scans HTML files for asset references.
# Checks if file exists.
# If not, searches for the filename (ignoring path) in assets/.
# Updates HTML if found.

$root = Get-Location
$assetsPath = Join-Path $root "assets"
$htmlFiles = Get-ChildItem -Path $root -Filter *.html -Recurse

# Initial indexing of all assets by Name -> FullPath
Write-Host "Indexing assets..."
$assetIndex = @{}
$assetItems = Get-ChildItem -Path $assetsPath -Recurse -File
foreach ($item in $assetItems) {
    if (-not $assetIndex.ContainsKey($item.Name)) {
        $assetIndex[$item.Name] = $item.FullName
    } else {
        # Duplicate name? Prefer the one at root or handle specific logic?
        # For now, first wins, or maybe "shortest path" wins.
        $existing = $assetIndex[$item.Name]
        if ($item.FullName.Length -lt $existing.Length) {
            $assetIndex[$item.Name] = $item.FullName
        }
    }
}

foreach ($html in $htmlFiles) {
    Write-Host "Checking $($html.Name)..."
    $content = Get-Content $html.FullName -Raw
    $newContent = $content
    $changed = $false
    
    # Regex to find src="assets/..." or href="assets/..."
    # Matches: (src|href)=["'](assets/[^"']+)["']
    # Note: Handles " ' and plain assets/ prefix
    
    $matches = [regex]::Matches($content, '(src|href)=["''](assets/[^"''#?]+)["'']')
    
    foreach ($match in $matches) {
        $fullMatch = $match.Value # src="assets/..."
        $relPath = $match.Groups[2].Value # assets/...
        
        # Decode URL chars
        $decodedPath = [System.Web.HttpUtility]::UrlDecode($relPath)
        
        # Check existence
        $fullPath = Join-Path $root $decodedPath
        
        if (-not (Test-Path $fullPath)) {
            Write-Host "  Broken Link: $relPath"
            
            # Extract filename
            $filename = Split-Path $decodedPath -Leaf
            
            # Check Index
            if ($assetIndex.ContainsKey($filename)) {
                $foundPath = $assetIndex[$filename]
                $newRelPath = [System.IO.Path]::GetRelativePath($root.FullName, $foundPath).Replace("\", "/")
                
                Write-Host "    -> Found at: $newRelPath"
                
                # Replace in Content
                # Be careful to replace only this instance or all?
                # String Replace might target wrong things if short.
                # But assets paths are usually unique enough.
                
                $newContent = $newContent.Replace($relPath, $newRelPath)
                $changed = $true
            } else {
                Write-Host "    -> NOT FOUND in assets index ($filename)"
            }
        }
    }
    
    if ($changed) {
        Write-Host "  Saving changes..."
        Set-Content -LiteralPath $html.FullName -Value $newContent -Encoding UTF8
    }
}
