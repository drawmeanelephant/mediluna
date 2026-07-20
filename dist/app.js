/* ==========================================================================
   MEDILUNA APP SCRIPT
   Core Interactions, Gallery Filtering, Lightbox, and Snack Station Mini-Game
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  // --- DOM Elements ---
  const body = document.body;
  const themeToggleBtn = document.getElementById('theme-toggle-btn');
  
  // Gallery
  const filterTabs = document.querySelectorAll('.filter-tab');
  const galleryCards = document.querySelectorAll('.gallery-card');
  const previewButtons = document.querySelectorAll('.preview-btn');
  
  // Lightbox Modal
  const lightboxModal = document.getElementById('lightbox-modal');
  const lightboxImg = document.getElementById('lightbox-img-element');
  const lightboxTitle = document.getElementById('lightbox-title-element');
  const lightboxCloseBtn = document.getElementById('lightbox-close-btn');
  
  // Snack Station Game
  const feedFishBtn = document.getElementById('feed-fish-btn');
  const fishCounter = document.getElementById('fish-counter');
  const medilunaBubble = document.getElementById('mediluna-bubble');
  const medilunaAvatarGame = document.getElementById('mediluna-avatar-game');
  const streakBadge = document.getElementById('streak-badge');
  
  // Copy Prompt
  const copyPromptBtn = document.getElementById('copy-prompt-btn');
  const promptCopierText = document.getElementById('prompt-copier');

  // --- Theme Toggle Logic ---
  // Default theme is dark-theme
  if (!body.classList.contains('dark-theme') && !body.classList.contains('light-theme')) {
    body.classList.add('dark-theme');
  }

  themeToggleBtn.addEventListener('click', () => {
    if (body.classList.contains('dark-theme')) {
      body.classList.replace('dark-theme', 'light-theme');
      localStorage.setItem('theme', 'light');
    } else {
      body.classList.replace('light-theme', 'dark-theme');
      localStorage.setItem('theme', 'dark');
    }
  });

  // Load Saved Theme
  const savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'light') {
    body.classList.replace('dark-theme', 'light-theme');
  }

  // --- Gallery Filter Logic ---
  filterTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      // Deactivate other tabs, activate current
      filterTabs.forEach(t => tab !== t && t.classList.remove('active'));
      tab.classList.add('active');

      const filterValue = tab.getAttribute('data-filter');

      // Show/Hide Cards
      galleryCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        if (filterValue === 'all' || cardCategory === filterValue) {
          card.style.display = 'flex';
          // Fade-in animation
          card.style.opacity = '0';
          setTimeout(() => {
            card.style.transition = 'opacity 0.4s ease';
            card.style.opacity = '1';
          }, 10);
        } else {
          card.style.display = 'none';
        }
      });
    });
  });

  // --- Lightbox Modal Logic ---
  const openLightbox = (src, title) => {
    lightboxImg.src = src;
    lightboxImg.alt = title;
    lightboxTitle.textContent = title;
    lightboxModal.classList.add('active');
    lightboxModal.setAttribute('aria-hidden', 'false');
    // Lock body scroll
    body.style.overflow = 'hidden';
  };

  const closeLightbox = () => {
    lightboxModal.classList.remove('active');
    lightboxModal.setAttribute('aria-hidden', 'true');
    // Unlock body scroll
    body.style.overflow = '';
  };

  previewButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const src = btn.getAttribute('data-img-src');
      const title = btn.getAttribute('data-img-title');
      openLightbox(src, title);
    });
  });

  // Close triggers
  lightboxCloseBtn.addEventListener('click', closeLightbox);
  lightboxModal.addEventListener('click', (e) => {
    if (e.target === lightboxModal) {
      closeLightbox();
    }
  });

  // ESC key listener for lightbox
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && lightboxModal.classList.contains('active')) {
      closeLightbox();
    }
  });

  // --- Snack Station Game ---
  let fishFedCount = parseInt(localStorage.getItem('fishFedCount')) || 0;
  fishCounter.textContent = fishFedCount;
  updateStreakBadge(fishFedCount);

  // Canonical optimistic compiler/developer tips from Mediluna
  const medilunaTips = [
    "“This compile error is just the compiler's way of saying: 'Hey, I love your code! Let's eat a snack before we proceed!'” 🦦💚",
    "“Zig says 'build failed'? Oh, don't worry, the local mountain hiking trail is calling. Let's get outside first!” 🌲🎒",
    "“Unused variable? She is just keeping it warm for later. Don't delete it, give it a tiny bandana instead! 🧣”",
    "“Segmentation fault? That sounds like a fancy way to say 'it is swimming time!' Go wash your face with cold water, then let's write it again.” 🏊‍♀️🐟",
    "“A compiler error is simply a helpful list of friendly suggestions to read after a nice, delicious lunch!” 🥪",
    "“Do not stress about that dangling pointer, it is probably just pointing to the nearest snack jar! Let's follow it.” 🍪",
    "“You have been debugging this for over an hour! That is canonically four fish-feeding times. Let's take a break!” 🐟🦦",
    "“If your git branch is a mess, just remember: if someone draws me shaped like a potato, I'm still Mediluna. Your code is still excellent!” 🥔💚",
    "“Deadlines are optional. Fish are mandatory. Let's ignore that email and focus on acquiring fish!” 🐟🎒",
    "“Uncle Gravity told me once that the best code is the code we write after we've had a long, beautiful nap.” 😴✨",
    "“Is your unit test failing? Maybe it is just tired. Let's give it a little blanket (and feed it some snacks).” 🛌🍿",
    "“I don't know what Zig is, but Boris seems to compile things very fast. If Boris gets stuck, try giving him a hug!” 🧸"
  ];

  function updateStreakBadge(count) {
    if (count === 0) {
      streakBadge.style.display = 'none';
    } else {
      streakBadge.style.display = 'inline-block';
      if (count < 3) {
        streakBadge.textContent = "🔥 Status: Snack Enthusiast";
        streakBadge.style.backgroundColor = "var(--accent-blue)";
      } else if (count < 8) {
        streakBadge.textContent = "🔥 Status: Professional Fish Acquirer";
        streakBadge.style.backgroundColor = "var(--accent-orange)";
      } else {
        streakBadge.textContent = "🔥 Status: Legendary Mountain Guide 🦦🏔️";
        streakBadge.style.backgroundColor = "var(--accent-red)";
      }
    }
  }

  feedFishBtn.addEventListener('click', () => {
    // 1. Increment Count
    fishFedCount++;
    fishCounter.textContent = fishFedCount;
    localStorage.setItem('fishFedCount', fishFedCount);
    updateStreakBadge(fishFedCount);

    // 2. Play Avatar Eating Animation
    medilunaAvatarGame.classList.add('shaking');
    setTimeout(() => medilunaAvatarGame.classList.remove('shaking'), 400);

    // 3. Play Confetti!
    confetti({
      particleCount: 80,
      spread: 60,
      origin: { y: 0.7 },
      colors: ['#f53500', '#c77e00', '#3498db', '#ff8da1']
    });

    // 4. Update Speech Bubble with randomized advice
    const randomIndex = Math.floor(Math.random() * medilunaTips.length);
    const tip = medilunaTips[randomIndex];
    
    // Bubble scale/fade effect
    medilunaBubble.style.opacity = '0';
    medilunaBubble.style.transform = 'translateX(-50%) scale(0.9)';
    
    setTimeout(() => {
      medilunaBubble.textContent = tip;
      medilunaBubble.style.opacity = '1';
      medilunaBubble.style.transform = 'translateX(-50%) scale(1)';
    }, 150);
  });

  // --- Copy Prompt template Logic ---
  copyPromptBtn.addEventListener('click', () => {
    const textToCopy = promptCopierText.textContent;
    navigator.clipboard.writeText(textToCopy)
      .then(() => {
        copyPromptBtn.textContent = "Copied! 💚";
        copyPromptBtn.classList.add('btn-primary');
        copyPromptBtn.classList.remove('btn-secondary');
        
        setTimeout(() => {
          copyPromptBtn.textContent = "Copy Prompt 📋";
          copyPromptBtn.classList.add('btn-secondary');
          copyPromptBtn.classList.remove('btn-primary');
        }, 2000);
      })
      .catch(err => {
        console.error('Could not copy text: ', err);
      });
  });
});
