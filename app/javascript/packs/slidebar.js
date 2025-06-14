document.addEventListener("turbolinks:load", () => {
  const menuToggle = document.getElementById("menuToggle");
  const menuClose = document.getElementById("menuClose");
  const slideMenu = document.getElementById("slideMenu");

  if (!menuToggle || !slideMenu || !menuClose) return;

  // 開く
  menuToggle.addEventListener("click", (e) => {
    e.stopPropagation();  // 外部クリック判定から除外
    slideMenu.classList.add("active");
    slideMenu.style.transform = "translateX(0)";
  });

  // 閉じるボタンで閉じる
  menuClose.addEventListener("click", () => {
    slideMenu.classList.remove("active");
    slideMenu.style.transform = "translateX(100%)";
  });

  // メニュー外クリックで閉じる
  document.addEventListener("click", (e) => {
    if (
      slideMenu.classList.contains("active") &&
      !slideMenu.contains(e.target) &&
      e.target !== menuToggle
    ) {
      slideMenu.classList.remove("active");
      slideMenu.style.transform = "translateX(100%)";
    }
  });
});