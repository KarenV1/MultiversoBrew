/* Smooth scroll for anchors */
document.querySelectorAll('a[href^="#"]').forEach(a=>{
  a.addEventListener('click', e=>{
    const href = a.getAttribute('href');
    if(!href || href === '#') return;
    e.preventDefault();
    const el = document.querySelector(href);
    if(el) el.scrollIntoView({behavior:'smooth', block:'start'});
  });
});

/* Flip cards on button click (and click outside to close) */
document.querySelectorAll('.btn-flip').forEach(btn=>{
  btn.addEventListener('click', e=>{
    e.stopPropagation();
    const card = btn.closest('.card');
    if(card) card.classList.toggle('flipped');
  });
});

/* Close any flipped card when clicking elsewhere on document */
document.addEventListener('click', e=>{
  document.querySelectorAll('.card.flipped').forEach(c=>{
    // only close if the click is outside the card
    if(!c.contains(e.target)) c.classList.remove('flipped');
  });
});

/* Build manual carousels + dots and manual navigation (no auto-advance) */
document.querySelectorAll('.carousel-container').forEach(container=>{
  const carousel = container.querySelector('.carousel');
  const cards = Array.from(carousel.querySelectorAll('.card'));
  const dotsContainer = container.querySelector('.dots');

  if(!carousel || cards.length === 0) return;

  // create dots (one per card)
  dotsContainer.innerHTML = '';
  cards.forEach((_, i)=>{
    const d = document.createElement('button');
    d.className = 'dot';
    d.setAttribute('aria-label', 'Ir a producto ' + (i+1));
    dotsContainer.appendChild(d);
  });

  const dots = Array.from(dotsContainer.querySelectorAll('.dot'));
  let currentIndex = 0;

  // calculate step: use card offsetWidth + gap (approx)
  function getStep(){
    const card = carousel.querySelector('.card');
    if(!card) return 340;
    const style = getComputedStyle(carousel);
    const gap = parseFloat(style.gap || style.columnGap || 28);
    return Math.round(card.offsetWidth + (isNaN(gap) ? 28 : gap));
  }

  function update(){
    const step = getStep();
    // limit transform so last card fully visible:
    const maxTranslate = Math.max(0, (cards.length * step) - carousel.clientWidth + 8);
    let tx = Math.min(currentIndex * step, maxTranslate);
    carousel.style.transform = `translateX(-${tx}px)`;
    dots.forEach((dot, i)=> dot.classList.toggle('active', i === currentIndex));
  }

  // dot click
  dots.forEach((dot, i)=>{
    dot.addEventListener('click', ()=>{
      currentIndex = i;
      update();
    });
  });

  // support keyboard left/right when focus inside container
  container.addEventListener('keydown', e=>{
    if(e.key === 'ArrowRight'){ currentIndex = Math.min(currentIndex+1, cards.length-1); update(); }
    if(e.key === 'ArrowLeft'){ currentIndex = Math.max(currentIndex-1, 0); update(); }
  });

  // allow swipe / drag to move carousel (mobile friendly)
  let isDown=false,startX=0,scrollLeft=0;
  carousel.addEventListener('pointerdown', e=>{
    isDown=true;carousel.style.cursor='grabbing';startX=e.clientX;carousel.dataset.start=carousel.scrollLeft;
  });
  carousel.addEventListener('pointerup', ()=>{
    isDown=false;carousel.style.cursor='';
  });
  carousel.addEventListener('pointermove', e=>{
    if(!isDown) return;
    const dx = e.clientX - startX;
    carousel.scrollLeft = (carousel.dataset.start|0) - dx;
  });

  // initial
  update();

  // recompute on resize
  window.addEventListener('resize', ()=>{ update(); });

});
 
/* Forms */
const reviewForm = document.querySelector('.dejar-reseña form');
if(reviewForm){
  reviewForm.addEventListener('submit', e=>{
    e.preventDefault();
    alert('¡Gracias por tu reseña!');
    reviewForm.reset();
  });
}

const contactForm = document.querySelector('#contacto form');
if(contactForm){
  contactForm.addEventListener('submit', e=>{
    e.preventDefault();
    alert('Mensaje enviado. ¡Gracias por contactarnos!');
    contactForm.reset();
  });
}
