# Replaces 'Fixit' with 'Bybytto' (and 'fixit' with 'bybytto') in all .html files
param(
    [string]$Root = "${PWD}"
)

Write-Host "Searching for .html files under: $Root"

$files = Get-ChildItem -Path $Root -Recurse -Filter *.html -File -ErrorAction SilentlyContinue
foreach ($f in $files) {
    $path = $f.FullName
    $content = Get-Content -Raw -LiteralPath $path -ErrorAction SilentlyContinue
    if ($null -eq $content) { continue }

    $original = $content

    # Replace capitalized and lowercase occurrences separately to preserve case
    $content = $content -replace 'Fixit', 'Bybytto'
    $content = $content -replace 'fixit', 'bybytto'

    if ($content -ne $original) {
        # Create a backup
        Copy-Item -LiteralPath $path -Destination ($path + '.bak') -Force
        Set-Content -LiteralPath $path -Value $content -Force
        Write-Host "Updated: $path"
    }
}

Write-Host "Replacement complete. Backups created with .bak extension where changes occurred."
