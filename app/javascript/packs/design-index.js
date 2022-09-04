import Vue from 'vue'
import DesignIndex from '../design-index.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-index'
  const designIndex = document.querySelector(selector)
  if (designIndex) {
    new Vue({
      render: (h) => h(DesignIndex)
    }).$mount(selector)
  }
})
