import { createApp } from 'vue'
import DesignNew from '../design-new.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-new'
  const designNew = document.querySelector(selector)
  if (designNew) {
    createApp(DesignNew).mount(selector)
  }
})
