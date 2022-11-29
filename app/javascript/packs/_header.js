document.addEventListener('DOMContentLoaded', () => {
  const hamburgerMenu = document.getElementById('nav-toggle')
  hamburgerMenu.addEventListener('click', () => {
    document.body.classList.toggle('open')
  })
})
