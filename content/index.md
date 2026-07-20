---
title: Mediluna — Official Companion
---

<!-- Hero Section -->
<section class="hero-section" id="hero">
  <div class="section-container hero-container">
    <div class="hero-content">
      <div class="tagline-badge">🦦 Official Companion</div>
      <h1 class="hero-title">Mediluna</h1>
      <p class="hero-tagline">“Acquire fish. Ignore deadlines.”</p>
      <p class="hero-description">
        Mediluna is the endlessly optimistic, red-bandana-wearing otter who accompanies engineers on long coding adventures. She is not a software engineer, but she is convinced every compiler warning can be solved after a snack.
      </p>
      <div class="hero-cta-buttons">
        <a href="#snack-station" class="btn btn-primary" id="cta-feed-btn">Feed Mediluna 🐟</a>
        <a href="#gallery" class="btn btn-secondary" id="cta-gallery-btn">Download Assets</a>
      </div>
    </div>
    <div class="hero-visual">
      <div class="mascot-holder">
        <img src="art/mascot.png" alt="Mediluna Mascot" class="hero-mascot-img animate-float">
        <div class="mascot-backdrop-glow"></div>
      </div>
    </div>
  </div>
</section>

<!-- About / Personality Section -->
<section class="about-section" id="about">
  <div class="section-container">
    <div class="section-header text-center">
      <h2 class="section-title">Endlessly Optimistic, Always Prepared</h2>
      <p class="section-subtitle">She doesn't write code. She makes writing code feel like an adventure.</p>
    </div>
    
    <!-- Grid of Characteristics -->
    <div class="characteristics-grid">
      <div class="char-card">
        <div class="char-icon">🦦</div>
        <h3>Endlessly Optimistic</h3>
        <p>Convinced that every problem has an elegant solution, usually involving an immediate lunch break.</p>
      </div>
      <div class="char-card">
        <div class="char-icon">🎒</div>
        <h3>Always Prepared</h3>
        <p>Her tiny backpack is packed with essential developer tools: bandanas, snack bars, and spare hope.</p>
      </div>
      <div class="char-card">
        <div class="char-icon">🐟</div>
        <h3>Highly Motivated</h3>
        <p>Will gladly supervise release engineering, review PRs, or check compiler logs for the price of one fresh fish.</p>
      </div>
      <div class="char-card">
        <div class="char-icon">🌲</div>
        <h3>Happiest Outside</h3>
        <p>Believes that standing up, stepping away from the keyboard, and walking in nature solves 99% of compiler errors.</p>
      </div>
    </div>
  </div>
</section>

<!-- Snack Station (Interactive Widget) -->
<section class="snack-section" id="snack-station">
  <div class="section-container">
    <div class="snack-card glass-panel">
      <div class="snack-grid">
        <div class="snack-avatar-column">
          <div class="snack-avatar-wrapper">
            <img src="avatars/avatar_standard.png" alt="Mediluna Feeding Avatar" class="snack-avatar-img" id="mediluna-avatar-game">
            <div class="speaking-bubble" id="mediluna-bubble">
              "Hello! If you're stuck on a tricky compile error, feed me a fish. I'll give you my best advice!"
            </div>
          </div>
        </div>
        <div class="snack-game-column">
          <span class="widget-tag">Interactive Widget</span>
          <h2>Snack Station</h2>
          <p class="snack-desc">
            Mediluna's compiler troubleshooting checklist begins and ends with delicious snacks. Feed her a fish to cheer her up and unlock her canonical troubleshooting wisdom.
          </p>
          
          <div class="counter-display">
            <span class="counter-label">Fish Acquired:</span>
            <span class="counter-value" id="fish-counter">0</span>
          </div>
          
          <div class="feeding-controls">
            <button class="btn btn-primary btn-lg btn-glow-feed" id="feed-fish-btn">
              Feed Mediluna a Fish! 🐟
            </button>
          </div>
          
          <div class="streak-badge-container">
            <span class="streak-badge" id="streak-badge" style="display: none;">🔥 Level: Happy Otter</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Brand Asset Gallery Section -->
<section class="gallery-section" id="gallery">
  <div class="section-container">
    <div class="section-header">
      <h2 class="section-title">Brand & Core Assets</h2>
      <p class="section-subtitle font-sm">Download official, high-quality Mediluna wallpapers, stickers, avatars, and graphics.</p>
    </div>

    <!-- Category Filter Tabs -->
    <div class="gallery-filters" id="gallery-tabs">
      <button class="filter-tab active" data-filter="all">All Assets</button>
      <button class="filter-tab" data-filter="art">Art</button>
      <button class="filter-tab" data-filter="stickers">Stickers</button>
      <button class="filter-tab" data-filter="wallpapers">Wallpapers</button>
      <button class="filter-tab" data-filter="avatars">Avatars</button>
      <button class="filter-tab" data-filter="logos">Logos</button>
    </div>

    <!-- Gallery Grid -->
    <div class="gallery-grid" id="gallery-grid-container">
      <!-- Asset Card 1 -->
      <div class="gallery-card" data-category="art">
        <div class="gallery-img-wrapper">
          <img src="art/mascot.png" alt="Official Mascot Art" class="gallery-img">
          <button class="preview-btn" data-img-src="art/mascot.png" data-img-title="Official Mascot Art">Preview</button>
        </div>
        <div class="gallery-card-info">
          <span class="asset-category">Art</span>
          <h3>Official Mascot Art</h3>
          <span class="asset-specs">1024 x 1024 • PNG</span>
          <a href="art/mascot.png" download="mediluna_mascot.png" class="btn-download">Download 📥</a>
        </div>
      </div>

      <!-- Asset Card 2 -->
      <div class="gallery-card" data-category="stickers">
        <div class="gallery-img-wrapper">
          <img src="stickers/sticker_got_this.png" alt="You Got This Sticker" class="gallery-img">
          <button class="preview-btn" data-img-src="stickers/sticker_got_this.png" data-img-title="You Got This Sticker">Preview</button>
        </div>
        <div class="gallery-card-info">
          <span class="asset-category">Sticker</span>
          <h3>"You Got This!" Sticker</h3>
          <span class="asset-specs">1024 x 1024 • Die-Cut PNG</span>
          <a href="stickers/sticker_got_this.png" download="mediluna_sticker_got_this.png" class="btn-download">Download 📥</a>
        </div>
      </div>

      <!-- Asset Card 3 -->
      <div class="gallery-card" data-category="wallpapers">
        <div class="gallery-img-wrapper">
          <img src="wallpapers/wallpaper_adventure.png" alt="Mountain Trail Sunset Wallpaper" class="gallery-img">
          <button class="preview-btn" data-img-src="wallpapers/wallpaper_adventure.png" data-img-title="Mountain Trail Sunset Wallpaper">Preview</button>
        </div>
        <div class="gallery-card-info">
          <span class="asset-category">Wallpaper</span>
          <h3>Mountain sunset wallpaper</h3>
          <span class="asset-specs">1920 x 1080 (16:9) • PNG</span>
          <a href="wallpapers/wallpaper_adventure.png" download="mediluna_wallpaper_adventure.png" class="btn-download">Download 📥</a>
        </div>
      </div>

      <!-- Asset Card 4 -->
      <div class="gallery-card" data-category="avatars">
        <div class="gallery-img-wrapper">
          <img src="avatars/avatar_standard.png" alt="Standard Profile Avatar" class="gallery-img">
          <button class="preview-btn" data-img-src="avatars/avatar_standard.png" data-img-title="Standard Profile Avatar">Preview</button>
        </div>
        <div class="gallery-card-info">
          <span class="asset-category">Avatar</span>
          <h3>Standard Profile Avatar</h3>
          <span class="asset-specs">1024 x 1024 • PNG</span>
          <a href="avatars/avatar_standard.png" download="mediluna_avatar_standard.png" class="btn-download">Download 📥</a>
        </div>
      </div>

      <!-- Asset Card 5 -->
      <div class="gallery-card" data-category="logos">
        <div class="gallery-img-wrapper">
          <img src="logos/logo_simple.png" alt="Minimalist Logo" class="gallery-img">
          <button class="preview-btn" data-img-src="logos/logo_simple.png" data-img-title="Minimalist Logo">Preview</button>
        </div>
        <div class="gallery-card-info">
          <span class="asset-category">Logo</span>
          <h3>Minimalist vector logo</h3>
          <span class="asset-specs">1024 x 1024 • Vector Style PNG</span>
          <a href="logos/logo_simple.png" download="mediluna_logo_simple.png" class="btn-download">Download 📥</a>
        </div>
      </div>
    </div>
  </div>
</section>
