param (
    [string]$Target = "."
)

try {
    [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)
} catch {
}

function Fix-Encoding {
    param([string]$FilePath)

    Write-Host "Processing $FilePath..."
    
    try {
        $content = Get-Content -LiteralPath $FilePath -Encoding UTF8 -Raw
        
        # MOJIBAKE RECOVERY ATTEMPT
        # We assume content is: [Original UTF-8 Bytes] interpreted as [Windows-1252] -> Saved as UTF-8
        # We reverse: [Saved Content] encoded as [Windows-1252] -> Decoded as [UTF-8]
        
        try {
            $enc1252 = [System.Text.Encoding]::GetEncoding(1252)
            # This might fail if content has chars not in 1252 (e.g. emojis, some math symbols)
            # But true mojibake usually only consists of 1252 chars.
            $bytes = $enc1252.GetBytes($content)
            
            $encUtf8 = [System.Text.Encoding]::UTF8
            # This might fail (or produce weird results) if the bytes aren't valid UTF-8
            $fixed = $encUtf8.GetString($bytes)
            
            # Additional Check:
            # If the repair worked, we expect the file length (chars) to decrease (since 2-3 chars combine to 1)
            # or at least stay same (unlikely).
            
            if ($fixed.Length -lt $content.Length) {
                Write-Host "  -> Repair successful (Length reduced: $($content.Length) -> $($fixed.Length))"
                Set-Content -LiteralPath $FilePath -Value $fixed -Encoding UTF8
            } elseif ($fixed -ne $content) {
                 # Length same but content different? Rare for this type of mojibake.
                 # But if we fixed it, let's save.
                 Write-Host "  -> Repair successful (Content changed)"
                 Set-Content -LiteralPath $FilePath -Value $fixed -Encoding UTF8
            } else {
                 Write-Host "  -> No change after repair logic."
            }
            
        } catch {
            Write-Host "  -> Skipped (Not mojibake or not reversible): $_"
        }
    } catch {
        Write-Host "  -> Error reading: $_"
    }
}

if (Test-Path -Path $Target -PathType Leaf) {
    Fix-Encoding -FilePath $Target
} else {
    $files = Get-ChildItem -Path $Target -Filter *.html -Recurse
    foreach ($file in $files) {
        Fix-Encoding -FilePath $file.FullName
    }
}
