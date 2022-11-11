import Vue from 'vue'
import DesignEdit from '../design-edit'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-design-edit'
  const designEdit = document.querySelector(selector)
  if (designEdit) {
    new Vue({
      render: (h) => h(DesignEdit)
    }).$mount(selector)
  }
})
