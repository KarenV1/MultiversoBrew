# Get the CSS file content
$content = Get-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -Raw

# Replace the 600px media query carousel-container section
$content = $content -replace '(@media \(max-width: 600px\) \{[\s\S]*?)(\.carousel-container \{\r?\n\s+padding: 100px 0 16px;)', '$1.carousel-container {' + "`r`n        padding: 100px 16px 16px;"

# Add width and overflow to carousel-container
$content = $content -replace '(\.carousel-container \{[^\}]+align-items: center;)', '$1' + "`r`n        width: 100%;`r`n        overflow: visible;"

# Change carousel width from 100vw to 100%
$content = $content -replace 'width: 100vw;', 'width: 100%;'
$content = $content -replace 'max-width: 100vw;', 'max-width: 100%;'

# Fix carousel padding
$content = $content -replace '(\.carousel \{[^\}]+)padding: 0 0 14px;', '$1padding: 0 8px 14px 8px;'

# Add overflow-y and scroll-behavior to carousel
$content = $content -replace '(\.carousel \{[^\}]+overflow-x: auto;)', '$1' + "`r`n        overflow-y: visible;"
$content = $content -replace '(\.carousel \{[^\}]+)-webkit-overflow-scrolling: touch;', '$1-webkit-overflow-scrolling: touch;' + "`r`n        scroll-behavior: smooth;"

# Fix card margin
$content = $content -replace '(\.card \{[^\}]+margin:) 0 auto;', '$1 0;'

# Add overflow: visible to card
$content = $content -replace '(\.card \{[^\}]+scroll-snap-align: center;)', '$1' + "`r`n        overflow: visible;"

# Remove duplicate .card, .card-inner, and .carousel rules
$content = $content -replace '\s+\.card \{\r?\n\s+flex: 0 0 210px;\r?\n\s+width: 210px;\r?\n\s+height: 210px;\r?\n\s+margin: 0( auto)?;\r?\n\s+position: relative;\r?\n\s+scroll-snap-align: center;\r?\n\s+overflow: visible;\r?\n\s+\}\r?\n\s+\.card-inner \{\r?\n\s+overflow: visible;\r?\n\s+\}\r?\n\s+\.carousel \{\r?\n\s+overflow: visible;\r?\n\s+\}', "`r`n    .card-inner {`r`n        overflow: visible;`r`n    }"

# Fix card-front img
$content = $content -replace '(\.card-front img \{[^\}]+)box-shadow: 0 8px 24px rgba\(0,0,0,0\);', '$1filter: drop-shadow(0 8px 20px rgba(0, 0, 0, 0.5));'

# Save
$content | Set-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -NoNewline

Write-Host "CSS fixed successfully!"
