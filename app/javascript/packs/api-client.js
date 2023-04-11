import Rails from '@rails/ujs'
import axios from 'axios'

export default axios.create({
  baseURL: '/',
  headers: {
    'content-type': 'multipart/form-data',
    'X-CSRF-Token': Rails.csrfToken()
  }
})
