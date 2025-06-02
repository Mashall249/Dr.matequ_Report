document.addEventListener('turbolinks:load', function () {
  const menuButton = document.getElementById('menu-button');
  const sidebar = document.getElementById('sidebar');

  if (menuButton && sidebar) {
    menuButton.addEventListener('click', () => {
      sidebar.classList.toggle('show');
    });
  }
});