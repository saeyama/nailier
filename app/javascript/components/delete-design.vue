<template>
  <button @click="deleteDesign"><slot></slot></button>
</template>

<script>
import apiClient from '../packs/api-client.js'
export default {
  name: 'DeleteDesign',
  props: {
    id: { type: [String, Number], required: true }
  },
  methods: {
    deleteDesign() {
      const resultOfDesignDelete = confirm(
        'この操作は取り消すことはできません。本当に削除しますか？'
      )
      if (resultOfDesignDelete) {
        apiClient
          .delete(`/api/designs/${this.id}`, {})
          .then(() => (window.location.href = '/designs'))
      } else {
        return
      }
    }
  }
}
</script>
