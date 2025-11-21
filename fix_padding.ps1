$content = Get-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -Raw

# Update the .carousel padding in the mobile media query
# Current: padding: 0 8px 14px 8px;
# New: padding: 60px 8px 14px 8px;
$content = $content -replace 'padding: 0 8px 14px 8px;', 'padding: 60px 8px 14px 8px;'

# Update the .carousel-container padding to compensate (optional, but good for spacing)
# Current: padding: 100px 16px 16px;
# New: padding: 40px 16px 16px; (100 - 60 = 40)
$content = $content -replace 'padding: 100px 16px 16px;', 'padding: 40px 16px 16px;'

$content | Set-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -NoNewline

Write-Host "Carousel padding updated!"
