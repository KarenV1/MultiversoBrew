$content = Get-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -Raw

# Find and replace the entire 600px media query section
$pattern = '@media \(max-width: 600px\) \{[\s\S]+?\n\}'

$replacement = @'
@media (max-width: 600px) {
    .navbar {
        padding: 8px 4px;
    }
    
    .navbar-section ul.menu-list {
        gap: 10px;
    }
    
    .navbar-center .logo img {
        height: 38px;
        width: 38px;
    }

    .navbar ul {
        display: none;
    }

    .menu-toggle {
        display: block;
    }

    .hero h1 {
        font-size: 32px;
    }

    .container {
        width: 98%;
        padding: 8px;
    }

    .carousel-container {
        padding: 100px 16px 16px;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        overflow: visible;
    }

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

    .card {
        flex: 0 0 210px;
        width: 210px;
        height: 210px;
        margin: 0;
        position: relative;
        scroll-snap-align: center;
        overflow: visible;
    }

    .card-inner {
        overflow: visible;
    }

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

    .card-front h3 {
        margin-top: 90px;
        font-size: 16px;
        text-align: center;
    }

    .dots {
        margin-top: 8px;
    }

    .carousel-prev,
    .carousel-next {
        display: none;
    }
}
'@

$content = $content -replace $pattern, $replacement

$content | Set-Content 'd:\Documentos\Cafeteria Scrum\MultiversoBrew\styles.css' -NoNewline

Write-Host "CSS restored and fixed!"
