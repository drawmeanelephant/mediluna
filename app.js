/* Mediluna's small, optional site interactions. */
document.addEventListener('DOMContentLoaded', () => {
  const body = document.body;
  const themeToggle = document.getElementById('theme-toggle-btn');

  if (themeToggle) {
    const savedTheme = localStorage.getItem('theme');
    body.classList.add(savedTheme === 'light' ? 'light-theme' : 'dark-theme');
    themeToggle.addEventListener('click', () => {
      const isLight = body.classList.toggle('light-theme');
      body.classList.toggle('dark-theme', !isLight);
      localStorage.setItem('theme', isLight ? 'light' : 'dark');
    });
  }

  const tabs = document.querySelectorAll('.filter-tab');
  const cards = document.querySelectorAll('.gallery-card');
  tabs.forEach((tab) => tab.addEventListener('click', () => {
    tabs.forEach((item) => item.classList.toggle('active', item === tab));
    cards.forEach((card) => {
      card.hidden = tab.dataset.filter !== 'all' && card.dataset.filter !== card.dataset.category;
    });
  }));

  const modal = document.getElementById('lightbox-modal');
  const modalImage = document.getElementById('lightbox-img-element');
  const modalTitle = document.getElementById('lightbox-title-element');
  const closeModal = () => {
    if (!modal) return;
    modal.classList.remove('active');
    modal.setAttribute('aria-hidden', 'true');
    body.style.overflow = '';
  };
  document.querySelectorAll('.preview-btn').forEach((button) => button.addEventListener('click', () => {
    if (!modal || !modalImage || !modalTitle) return;
    modalImage.src = button.dataset.imgSrc;
    modalImage.alt = button.dataset.imgTitle || '';
    modalTitle.textContent = button.dataset.imgTitle || 'Asset preview';
    modal.classList.add('active');
    modal.setAttribute('aria-hidden', 'false');
    body.style.overflow = 'hidden';
  }));
  document.getElementById('lightbox-close-btn')?.addEventListener('click', closeModal);
  modal?.addEventListener('click', (event) => { if (event.target === modal) closeModal(); });
  document.addEventListener('keydown', (event) => { if (event.key === 'Escape') closeModal(); });

  const feedButton = document.getElementById('feed-fish-btn');
  const fishCounter = document.getElementById('fish-counter');
  const bubble = document.getElementById('mediluna-bubble');
  if (feedButton && fishCounter && bubble) {
    let count = Number.parseInt(localStorage.getItem('fishFedCount') || '0', 10);
    const notes = [
      'A small pause can make room for a bright idea. 🐟',
      'Look at you, making progress one kind step at a time. 🌲',
      'Fresh air, a snack, and a little patience — a strong trail kit. 🎒'
    ];
    fishCounter.textContent = count;
    feedButton.addEventListener('click', () => {
      count += 1;
      fishCounter.textContent = count;
      localStorage.setItem('fishFedCount', count);
      bubble.textContent = notes[count % notes.length];
    });
  }

  const copyButton = document.getElementById('copy-prompt-btn');
  const prompt = document.getElementById('prompt-copier');
  copyButton?.addEventListener('click', async () => {
    if (!prompt || !navigator.clipboard) return;
    await navigator.clipboard.writeText(prompt.textContent || '');
    copyButton.textContent = 'Copied!';
  });
});
