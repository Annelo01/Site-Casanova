param (
    [string]$Target = "."
)

try {
    [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)
} catch {
}

function Fix-Encoding {
    param([string]$FilePath)

    Write-Host "Checking $FilePath..."
    
    try {
        $content = Get-Content -LiteralPath $FilePath -Encoding UTF8 -Raw
        
        # Debug: Print first occurrence of 'Ã'
        $idx = $content.IndexOf('Ã')
        if ($idx -ge 0) {
            Write-Host "  Found 'Ã' at index $idx"
            $substring = $content.Substring($idx, 5)
            Write-Host "  Context: '$substring'"
            $chars = $substring.ToCharArray()
            foreach ($c in $chars) {
                Write-Host "    Char: '$c' Int: $([int]$c)"
            }
        } else {
            Write-Host "  'Ã' not found in content (using -match 'Ã' might behave differently?)"
            if ($content -match "Ã") {
                Write-Host "  -match 'Ã' says true though!"
            }
        }

        # Force Fix for testing
        try {
            $enc1252 = [System.Text.Encoding]::GetEncoding(1252)
            $bytes = $enc1252.GetBytes($content)
            
            $encUtf8 = [System.Text.Encoding]::UTF8
            $fixed = $encUtf8.GetString($bytes)
            
            # Check if fixed content looks better
            if ($fixed -match "Ã") {
                 Write-Host "  -> Fix didn't remove Ã. Result sample: $($fixed.Substring($idx, 5))"
            } else {
                 Write-Host "  -> Fix seems to have worked in memory."
                 Set-Content -LiteralPath $FilePath -Value $fixed -Encoding UTF8
                 Write-Host "  -> Saved."
            }
            
        } catch {
            Write-Host "  -> Error converting: $_"
        }
    } catch {
        Write-Host "  -> Error reading: $_"
    }
}

Fix-Encoding -FilePath "coteaux-mesnil.html"
