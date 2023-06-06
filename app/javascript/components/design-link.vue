<template>
  <div @click="designLink" :link="link" class="cursor-pointer">
    <slot></slot>
  </div>
</template>

<script>
export default {
  name: 'DesignLink',
  props: {
    id: { type: [String, Number] },
    link: { type: String, required: true }
  },
  methods: {
    designLink() {
      if (this.link === 'index') {
        window.location.href = '/designs'
      }
      if (this.link === 'show') {
        window.location.href = `/designs/${this.id}`
      }
      if (this.link === 'new') {
        window.location.href = '/designs/new'
      }
      if (this.link === 'edit') {
        window.location.href = `/designs/${this.id}/edit`
      }
    }
  }
}
</script>
