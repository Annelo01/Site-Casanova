$files = Get-ChildItem ".\*.html"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Define regex pattern to match the image and h2. 
    # Using [^>]* to be non-greedy for attributes.
    # Using (?s) to make . match newlines if we used it, but here we specific keys.
    # \s* matches newlines between tags.
    $pattern = '(?i)<img\s+[^>]*src=["'']assets/img/logo-coeur\.png["''][^>]*>\s*<h2\s+class=["'']footer-brand-name["'']>.*?</h2>'
    
    if ($content -match $pattern) {
        $newContent = $content -replace $pattern, '<img src="assets/img/logo svg footpage.svg" alt="Aurore Casanova Champagne" class="footer-heart-logo">'
        if ($newContent -ne $content) {
            Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8 -NoNewline
            Write-Host "Updated: $($file.Name)"
        }
    } else {
        # Check if already updated
        if ($content -match 'logo svg footpage.svg') {
            Write-Host "Already updated: $($file.Name)"
        } else {
            Write-Host "Pattern NOT found in: $($file.Name)"
        }
    }

    # Also removing the empty duplicate if script ran partially? 
    # Just in case some files have double logos now? Unlikely with -replace.
}
