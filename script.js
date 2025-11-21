document.addEventListener('DOMContentLoaded', function () {

    // ==== SCROLL SUAVE PARA ANCLAS ====
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (!href || href === '#') return;

            e.preventDefault();
            const target = document.querySelector(href);
            if (target) {
                const navbarHeight = document.querySelector('.navbar').offsetHeight;
                window.scrollTo({
                    top: target.offsetTop - navbarHeight,
                    behavior: 'smooth'
                });
            }
        });
    });

    // ==== MENÚ HAMBURGUESA ====
    const menuToggle = document.querySelector('.menu-toggle');
    const menuList = document.querySelector('.menu-list');

    if (menuToggle && menuList) {
        menuToggle.addEventListener('click', function () {
            menuList.classList.toggle('active');
        });

        // Cierra el menú al seleccionar una opción
        document.querySelectorAll('.menu-list li a').forEach(link => {
            link.addEventListener('click', () => {
                menuList.classList.remove('active');
            });
        });
    }

    // ==== FLIP DE TARJETAS (voltea y regresa al dar clic) ====
    document.querySelectorAll('.btn-flip').forEach(button => {
        button.addEventListener('click', function (e) {
            e.stopPropagation();
            const card = this.closest('.card');
            if (card) card.classList.add('flipped');
        });
    });

    // Voltear de regreso al hacer clic en la tarjeta
    document.querySelectorAll('.card').forEach(card => {
        card.addEventListener('click', function () {
            if (this.classList.contains('flipped')) {
                this.classList.remove('flipped');
            }
        });
    });

    // ==== CARRUSELES MANUALES Y RESPONSIVOS ====
    document.querySelectorAll('.carousel-container').forEach(container => {
        const carousel = container.querySelector('.carousel');
        const cards = Array.from(carousel.querySelectorAll('.card'));
        const dotsContainer = container.querySelector('.dots');
        const prevBtn = container.querySelector('.carousel-prev');
        const nextBtn = container.querySelector('.carousel-next');

        if (!carousel || cards.length === 0) return;

        // Crea los puntos indicadores
        dotsContainer.innerHTML = '';
        cards.forEach((_, index) => {
            const dot = document.createElement('button');
            dot.className = 'dot';
            dot.setAttribute('aria-label', `Ir a producto ${index + 1}`);
            dotsContainer.appendChild(dot);
        });

        const dots = Array.from(dotsContainer.querySelectorAll('.dot'));

        // Función para obtener el ancho de paso (card + gap)
        function getStep() {
            const card = carousel.querySelector('.card');
            if (!card) return 340;
            const style = getComputedStyle(carousel);
            const gap = parseFloat(style.gap || 28);
            return card.offsetWidth + gap;
        }

        // Actualiza el punto activo basado en el scroll
        function updateActiveDot() {
            const step = getStep();
            const scrollLeft = carousel.scrollLeft;
            const index = Math.round(scrollLeft / step);

            dots.forEach((dot, i) => {
                dot.classList.toggle('active', i === index);
            });
        }

        // Escucha el evento de scroll nativo
        carousel.addEventListener('scroll', () => {
            window.requestAnimationFrame(updateActiveDot);
        });

        // Navegación con puntos
        dots.forEach((dot, index) => {
            dot.addEventListener('click', () => {
                const step = getStep();
                carousel.scrollLeft = index * step;
            });
        });

        // Navegación con botones
        if (prevBtn && nextBtn) {
            prevBtn.addEventListener('click', () => {
                const step = getStep();
                carousel.scrollLeft -= step;
            });

            nextBtn.addEventListener('click', () => {
                const step = getStep();
                carousel.scrollLeft += step;
            });
        }

        // Inicializa
        updateActiveDot();
    });

    // ==== FORMULARIOS ====
    const reviewForm = document.querySelector('.dejar-reseña form');
    if (reviewForm) {
        reviewForm.addEventListener('submit', function (e) {
            e.preventDefault();
            alert('¡Gracias por tu reseña, héroe! 🦸‍♂️ Tu opinión nos ayuda a mejorar el multiverso.');
            this.reset();
        });
    }

    const contactForm = document.querySelector('.contacto form');
    if (contactForm) {
        contactForm.addEventListener('submit', function (e) {
            e.preventDefault();
            alert('¡Mensaje enviado con éxito! 🦸‍♀️ Nos pondremos en contacto contigo pronto.');
            this.reset();
        });
    }
});
