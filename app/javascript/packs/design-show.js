import { createApp } from 'vue'
import DesignShow from '../design-show.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-show'
  const designShow = document.querySelector(selector)
  if (designShow) {
    createApp(DesignShow).mount(selector)
  }
})
