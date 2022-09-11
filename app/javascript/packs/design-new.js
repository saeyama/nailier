import Vue from 'vue'
import DesignNew from '../design-new.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-new'
  const designNew = document.querySelector(selector)
  if (designNew) {
    new Vue({
      render: (h) => h(DesignNew)
    }).$mount(selector)
  }
})
