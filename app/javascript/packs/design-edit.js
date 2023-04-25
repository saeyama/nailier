import { createApp } from 'vue'
import DesignEdit from '../design-edit.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-edit'
  const designEdit = document.querySelector(selector)
  if (designEdit) {
    createApp(DesignEdit).mount(selector)
  }
})
