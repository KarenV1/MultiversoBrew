$content = Get-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -Raw

# Fix carousel container padding
$content = $content -replace 'padding: 100px 0 16px;(\r?\n\s+display: flex;\r?\n\s+flex-direction: column;\r?\n\s+align-items: center;\r?\n\s+)', 'padding: 100px 16px 16px;$1width: 100%;$1overflow: visible;$1'

# Fix carousel width: change 100vw to 100% 
$content = $content -replace 'width: 100vw;\r?\n\s+max-width: 100vw;', 'width: 100%;
        max-width: 100%;'

# Add scroll-behavior to carousel
$content = $content -replace '(scroll-snap-type: x mandatory;\r?\n\s+-webkit-overflow-scrolling: touch;)', '$1
        scroll-behavior: smooth;'

# Change carousel overflow-x: auto to include overflow-y: visible
$content = $content -replace 'overflow-x: auto;(\r?\n\s+scroll-snap-type)', 'overflow-x: auto;
        overflow-y: visible;$1'

# Fix carousel padding
$content = $content -replace 'padding: 0 0 14px;(\r?\n\s+overflow-x)', 'padding: 0 8px 14px 8px;$1'

# Remove duplicate .carousel { overflow: visible; } and duplicate .card rules
$content = $content -replace '\s+\.card \{\r?\n\s+flex: 0 0 210px;\r?\n\s+width: 210px;\r?\n\s+height: 210px;\r?\n\s+margin: 0 auto;\r?\n\s+position: relative;\r?\n\s+scroll-snap-align: center;\r?\n\s+overflow: visible;\r?\n\s+\}\r?\n\s+\.card-inner \{\r?\n\s+overflow: visible;\r?\n\s+\}\r?\n\s+\.carousel \{\r?\n\s+overflow: visible;\r?\n\s+\}', '
    .card-inner {
        overflow: visible;
    }'

# Change card margin from "0 auto" to "0" for 600px breakpoint
$content = $content -replace '(\.card \{\r?\n\s+flex: 0 0 210px;\r?\n\s+width: 210px;\r?\n\s+height: 210px;\r?\n\s+)margin: 0 auto;', '$1margin: 0;'

# Fix box-shadow to use drop-shadow filter
$content = $content -replace 'box-shadow: 0 8px 24px rgba\(0,0,0,0\);', 'filter: drop-shadow(0 8px 20px rgba(0, 0, 0, 0.5));'

# Save the fixed content
$content | Set-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -NoNewline

Write-Host "Carousel CSS fixed successfully!"
