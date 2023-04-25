import { createApp } from 'vue'
import DesignIndex from '../design-index.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-index'
  const designIndex = document.querySelector(selector)
  if (designIndex) {
    createApp(DesignIndex).mount(selector)
  }
})
