// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap
import "@hotwired/turbo-rails"
import "controllers"

// ハンバーガーメニューの機能
function initializeHamburgerMenu() {
  const hamburgerMenu = document.getElementById('hamburger-menu');
  const navbarNav = document.getElementById('navbar-nav');
  
  if (hamburgerMenu && navbarNav) {
    // ハンバーガーボタンのクリックイベント
    hamburgerMenu.addEventListener('click', function() {
      hamburgerMenu.classList.toggle('active');
      navbarNav.classList.toggle('active');
    });

    // メニューリンクをクリックした時にメニューを閉じる
    const navLinks = navbarNav.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
      link.addEventListener('click', function() {
        hamburgerMenu.classList.remove('active');
        navbarNav.classList.remove('active');
      });
    });

    // 画面外をクリックした時にメニューを閉じる
    document.addEventListener('click', function(event) {
      if (!hamburgerMenu.contains(event.target) && !navbarNav.contains(event.target)) {
        hamburgerMenu.classList.remove('active');
        navbarNav.classList.remove('active');
      }
    });
  }
}

// DOMContentLoadedイベントで初期化
document.addEventListener('DOMContentLoaded', function() {
  initializeHamburgerMenu();
});

// Turboのページ遷移後にも初期化を実行
document.addEventListener('turbo:load', function() {
  initializeHamburgerMenu();
});

// Turboのframe読み込み後にも初期化を実行
document.addEventListener('turbo:frame-load', function() {
  initializeHamburgerMenu();
});
