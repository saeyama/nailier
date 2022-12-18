document.addEventListener('DOMContentLoaded', () => {
  const fadeTargets = document.querySelectorAll('.scroll-fade-in')

  const fadeOption = {
    root: null,
    rootMargin: '-10% 0px',
    threshold: [0]
  }

  const targets = (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('active')
      } else {
        entry.target.classList.remove('active')
      }
    })
  }

  const fadeObserver = new IntersectionObserver(targets, fadeOption)

  fadeTargets.forEach((target) => {
    fadeObserver.observe(target)
  })
})
