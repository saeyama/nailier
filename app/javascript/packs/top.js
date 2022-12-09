import Vue from 'vue'
import Top from '../top'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-top'
  const top = document.querySelector(selector)
  if (top) {
    new Vue({
      render: (h) => h(Top)
    }).$mount(selector)
  }
})
