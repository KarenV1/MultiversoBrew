# Read the content
$content = Get-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles_backup.css' -Raw

# Find the @media (max-width: 600px) section and replace it
$pattern = '(?s)(@media \(max-width: 600px\) \{.*?)(\.carousel-container \{.*?^\s*\})(.*?)(\.carousel \{.*?^\s*\})(.*?)(\.card \{.*?^\s*\})(.*?)(\.card-front img \{.*?^\s*\})(.*?)(\.card \{.*?^\s*\}.*?\.carousel \{.*?^\s*\})'

$replacement = '$1' + @'
.carousel-container {
        padding: 100px 16px 16px;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        overflow: visible;
    }
'@ + '$3' + @'
.carousel {
        display: flex;
        gap: 14px;
        padding: 0 8px 14px 8px;
        overflow-x: auto;
        overflow-y: visible;
        scroll-snap-type: x mandatory;
        -webkit-overflow-scrolling: touch;
        scroll-behavior: smooth;
        justify-content: flex-start;
        width: 100%;
        max-width: 100%;
        box-sizing: border-box;
    }
'@ + '$5' + @'
.card {
        flex: 0 0 210px;
        width: 210px;
        height: 210px;
        margin: 0;
        position: relative;
        scroll-snap-align: center;
        overflow: visible;
    }
'@ + '$7' + @'
.card-front img {
        width: 140px;
        height: 140px;
        top: -48px;
        left: 50%;
        transform: translateX(-50%);
        position: absolute;
        z-index: 2;
        object-fit: contain;
        background: transparent;
        filter: drop-shadow(0 8px 20px rgba(0, 0, 0, 0.5));
    }
    
    .card-inner {
        overflow: visible;
    }
'@

$content = $content -replace $pattern, $replacement

# Save the fixed content
$content | Set-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -NoNewline

Write-Host "CSS fixed successfully (using backup)!"
