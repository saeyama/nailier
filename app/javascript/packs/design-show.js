import Vue from 'vue'
import DesignShow from '../design-show.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-show'
  const designShow = document.querySelector(selector)
  if (designShow) {
    new Vue({
      render: (h) => h(DesignShow)
    }).$mount(selector)
  }
})
