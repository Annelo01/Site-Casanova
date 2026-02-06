# Aggressive Asset Standardization V2
# Renames all files and folders in assets/ to kebab-case
# Handles Folder Merging
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

# 1. Collect all items and build mapping
$mappings = @()

# Get all files and folders recursively
# Sort by Length Descending (Deepest first) immediately to simplify processing
$items = Get-ChildItem -Path $assetsPath -Recurse | Sort-Object -Property {$_.FullName.Length} -Descending

foreach ($item in $items) {
    if ($item.Name -match "\.ps1$|\.py$") { continue }

    $parentPath = $item.Directory.FullName
    $oldName = $item.Name
    $newName = Get-StandardName $oldName
    
    if ($oldName -ne $newName) {
        # We process immediately to avoid stale paths in objects?
        # No, if we rename directory A/B to A/b, then A/B/file.txt path is invalid.
        # But we sorted by Depth Descending.
        # So we process A/B/file.txt BEFORE A/B.
        # So A/B exists when we process the file.
        # When we process A/B, A/B/file.txt (renamed) is inside it.
        # This is safe.
        
        $newFullPath = Join-Path $parentPath $newName
        
        if ($item.PSIsContainer) {
            # FOLDER
            if (Test-Path $newFullPath) {
                Write-Host "Merging Folder: $oldName -> $newName"
                # Move all children from Old to New
                Get-ChildItem -Path $item.FullName | ForEach-Object {
                    $childName = $_.Name
                    $childDest = Join-Path $newFullPath $childName
                    if (Test-Path $childDest) {
                        Write-Host "  Collision for $childName. Deleting source (assuming duplicate/legacy)."
                        Remove-Item -LiteralPath $_.FullName -Force -Recurse
                    } else {
                        Move-Item -LiteralPath $_.FullName -Destination $childDest
                    }
                }
                # Remove empty old folder
                Remove-Item -LiteralPath $item.FullName -Force
            } else {
                Write-Host "Renaming Folder: $oldName -> $newName"
                Rename-Item -LiteralPath $item.FullName -NewName $newName
            }
        } else {
            # FILE
            if (Test-Path $newFullPath) {
                Write-Host "Duplicate File: $newName exists. Deleting $oldName."
                Remove-Item -LiteralPath $item.FullName -Force
            } else {
                Write-Host "Renaming File: $oldName -> $newName"
                Rename-Item -LiteralPath $item.FullName -NewName $newName
            }
        }
        
        # Add to mappings for HTML updates
        # Check if we need full relative path mapping
        # RelativePath is needed for HTML String Replacement.
        # But if we rename 'Folder' to 'folder', 'Folder/File.jpg' becomes 'folder/file.jpg'.
        # The HTML might have 'Folder/File.jpg'.
        # We need to map 'Folder/File.jpg' -> 'folder/file.jpg'.
        # Since we just renamed it, we can construct the map.
        
        $relOld = [System.IO.Path]::GetRelativePath($root.FullName, $item.FullName).Replace("\", "/")
        
        # Construct new relative path
        # We know parent path. But has the parent path changed yet?
        # We are processing DEEPEST first.
        # So parents have NOT been renamed yet.
        # So $parentPath is valid (old name).
        # But for HTML mapping, we need the *final* new path of the item?
        # No, we need old -> new.
        # Wait, if we rename 'A/B' to 'A/b', and later 'A' to 'a'.
        # Final path is 'a/b'.
        # HTML has 'A/B'.
        # Converting 'A/B' -> 'a/b' works by applying component replacements?
        # Or just 'A' -> 'a'? 
        # If HTML has 'A/B/img.jpg', and we replace 'A/B' with 'a/b', we get 'a/b/img.jpg'.
        # Then if we replace 'A' with 'a', we might mess up?
        # No, specificity wins.
        # 'A/B' (length 3) replaced.
        # 'A' (length 1) replaced.
        # Actually, simpler:
        # Just map the current component name change?
        # 'Folder' -> 'folder'.
        # If HTML contains 'Folder/', replace with 'folder/'.
        # BUT 'Folder' might appear in 'MyFolder/' which shouldn't change.
        # So we match path segments.
        
        # New Strategy for HTML:
        # Just standardizing the *text matching* of the specific old path string found in $relOld.
        # But $newRelPath needs to be calculated fully resolved.
        # Since we don't track full resolution here easily, let's regenerate the full standardized mapping 
        # based on the assumption that EVERYTHING becomes kebab-case.
        # So we don't need to track exact moves for HTML, we just need to know:
        # "If you see 'assets/img/1 AURE/File.jpg', replace with 'assets/img/1-aure/file.jpg'"
        
        $mappings += $relOld
    }
}

# 3. Update HTML
# Regenerate full mappings based on "Everything in assets/* is standardized" logic.
# Because the disk operations ensured everything IS standardized.

Write-Host "Updating HTML..."
$htmlFiles = Get-ChildItem -Path $root -Filter *.html -Recurse

foreach ($html in $htmlFiles) {
    $content = Get-Content $html.FullName -Raw
    $newContent = $content
    
    foreach ($oldPath in $mappings) {
        # $oldPath is like "assets/img/1 AURE/File.jpg"
        
        # Calculate expected new path by standardizing the whole string
        $parts = $oldPath -split "/"
        $newParts = @()
        foreach ($p in $parts) {
            if ($p -eq "assets") { $newParts += "assets" }
            else { $newParts += (Get-StandardName $p) }
        }
        $newPath = $newParts -join "/"
        
        # Replace Original
        if ($oldPath -ne $newPath) {
             # Escape for Regex not needed if using .Replace string method
             # But let's check for both URL encoded and normal
             
             $oldEncoded = $oldPath.Replace(" ", "%20")
             
             $newContent = $newContent.Replace($oldEncoded, $newPath)
             $newContent = $newContent.Replace($oldPath, $newPath)
        }
    }
    
    if ($content -ne $newContent) {
        Write-Host "Updated $($html.Name)"
        Set-Content -LiteralPath $html.FullName -Value $newContent -Encoding UTF8
    }
}

Write-Host "Aggressive Standardization V2 Complete."
