# Aggressive Asset Standardization
# Renames all files and folders in assets/ to kebab-case
# Deletes duplicates (if target exists)
# Updates HTML references

$root = Get-Location
$assetsPath = Join-Path $root "assets"

function Get-StandardName ($name) {
    # Lowercase
    $n = $name.ToLower()
    # Replace spaces and underscores with hyphens
    $n = $n.Replace(" ", "-").Replace("_", "-")
    # Remove multiple hyphens
    while ($n.Contains("--")) { $n = $n.Replace("--", "-") }
    return $n
}

# 1. Collect all items and build mapping (Depth First for folders?)
# We need Mappings: RelativePathOld -> RelativePathNew
# To calculate RelativePathNew, we need to know what the parent folder *will* be renamed to.
# So we can just simulate the renaming of the entire path string.

$mappings = @()

# Get all files and folders recursively
$items = Get-ChildItem -Path $assetsPath -Recurse

foreach ($item in $items) {
    # Skip script files in assets (unlikely but safe)
    if ($item.Name -match "\.ps1$|\.py$") { continue }

    $relPath = [System.IO.Path]::GetRelativePath($root.FullName, $item.FullName)
    $relPath = $relPath.Replace("\", "/") # Standardize to forward slashes for HTML/Regex
    
    # Calculate New Relative Path
    # Split by /
    $parts = $relPath -split "/"
    $newParts = @()
    foreach ($p in $parts) {
        if ($p -eq "assets") { 
            $newParts += "assets" 
        } else {
            $newParts += (Get-StandardName $p)
        }
    }
    $newRelPath = $newParts -join "/"
    
    if ($relPath -ne $newRelPath) {
        $mappings += [PSCustomObject]@{
            OldPath = $relPath
            NewPath = $newRelPath
            Type = if ($item.PSIsContainer) { "Folder" } else { "File" }
            Item = $item
        }
    }
}

# Sort Mappings by Length of OldPath Descending
# This ensures we replace "assets/img/folder/file.jpg" BEFORE "assets/img/folder"
# preventing partial replacements that break the path.
$mappings = $mappings | Sort-Object -Property {$_.OldPath.Length} -Descending

Write-Host "Planned changes: $($mappings.Count)"

# 2. Rename on Disk
# We must rename FILES first, then FOLDERS (Bottom Up).
# Actually, if we rename a folder `A` to `a`, the files inside are moved. 
# We should probably rename files in place, then rename folders bottom-up.
# But `Get-ChildItem` references might break if we move things.
# We should process items based on the sorted list? 
# If sorted by length desc, we process deepest files first. This is perfect.

foreach ($map in $mappings) {
    # Check if item still exists at location (it might have been deleted if it was a duplicate?)
    if (-not (Test-Path $map.Item.FullName)) {
        Write-Host "Skipping $($map.OldPath) (Not found)"
        continue
    }

    $parentPath = $map.Item.Directory.FullName
    $oldName = $map.Item.Name
    $newName = (Get-StandardName $oldName)
    $newFullPath = Join-Path $parentPath $newName

    if ($oldName -ne $newName) {
        if (Test-Path $newFullPath) {
            Write-Host "Duplicate found: $newName exists. Deleting $oldName."
            Remove-Item -LiteralPath $map.Item.FullName -Force -Recurse
        } else {
            Write-Host "Renaming $oldName -> $newName"
            Rename-Item -LiteralPath $map.Item.FullName -NewName $newName
        }
    }
}

# 3. Update HTML
$htmlFiles = Get-ChildItem -Path $root -Filter *.html -Recurse
foreach ($html in $htmlFiles) {
    Write-Host "Updating $($html.Name)..."
    $content = Get-Content $html.FullName -Raw
    
    foreach ($map in $mappings) {
        # Replace URL Encoded first (longer string usually?)
        # Use Regex Escape because paths have dots etc.
        
        $oldEncoded = $map.OldPath.Replace(" ", "%20")
        $newPath = $map.NewPath
        
        # We replace the relative path string in the HTML
        # We need to be careful. If HTML has `./assets/img/...`, our $map.OldPath is `assets/img/...`
        # Regex should match optional `./` or just `/` or beginning of string?
        # Let's just string replace the specific sequence.
        
        if ($content.Contains($oldEncoded)) {
            $content = $content.Replace($oldEncoded, $newPath)
        }
        if ($content.Contains($map.OldPath)) {
            $content = $content.Replace($map.OldPath, $newPath)
        }
    }
    
    Set-Content -LiteralPath $html.FullName -Value $content -Encoding UTF8
}

Write-Host "Aggressive standardization complete."
