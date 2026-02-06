$files = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $files) {
    Write-Host "Processing $($file.Name)..."
    $content = Get-Content $file.FullName -Raw

    # 1. Generic replacements for 05 MIGRATION folders
    # Handle both raw and URL encoded spaces
    $content = $content -replace '05 MIGRATION/assets/01 HOME PAGE/', './assets/img/'
    $content = $content -replace '05%20MIGRATION/assets/01%20HOME%20PAGE/', './assets/img/'
    
    $content = $content -replace '05 MIGRATION/assets/02 VINS & CHAMPAGNES/', './assets/img/'
    $content = $content -replace '05%20MIGRATION/assets/02%20VINS%20&%20CHAMPAGNES/', './assets/img/'
    $content = $content -replace '05%20MIGRATION/assets/02%20VINS%20%26%20CHAMPAGNES/', './assets/img/'
    
    $content = $content -replace '05 MIGRATION/assets/03 CONTACT/', './assets/img/'
    $content = $content -replace '05%20MIGRATION/assets/03%20CONTACT/', './assets/img/'
    
    $content = $content -replace '05 MIGRATION/assets/FAVICON/', './assets/img/'
    $content = $content -replace '05%20MIGRATION/assets/FAVICON/', './assets/img/'

    # 2. Font replacements
    $content = $content -replace '09 FONT/', './assets/fonts/'
    $content = $content -replace '09%20FONT/', './assets/fonts/'

    # 3. Fix video paths (they were moved to assets/vid but replaced as assets/img above)
    # Regex to find .mp4, .mov, .webm inside assets/img/ and allow optional ./
    $content = $content -replace 'assets/img/(.*\.mp4)', 'assets/vid/$1'
    $content = $content -replace 'assets/img/(.*\.mov)', 'assets/vid/$1'
    $content = $content -replace 'assets/img/(.*\.webm)', 'assets/vid/$1'

    # 4. Clean up any double dots/slashes if they occurred (e.g. ././)
    $content = $content -replace '\./\./', './'
    
    # 5. Case insensitivity fix for Hanken Grotesk fonts if needed
    # The file system has hkgrotesk-*.ttf (lowercase)
    # Convert HKGrotesk-*.ttf to hkgrotesk-*.ttf
    $content = $content -replace 'HKGrotesk-', 'hkgrotesk-'

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Patching complete."
