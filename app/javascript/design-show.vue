<template>
  <div>
    <h2>{{ design.title }}</h2>
    {{ design.nail_part }}<br />
    調べた内容・メモ<br />
    {{ design.description }}<br />
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      design: []
    }
  },
  mounted() {
    this.getDesign()
  },
  methods: {
    getDesign() {
      const url = location.pathname.split('/')
      const id = url[url.length - 1]
      axios
        .get(`/api/designs/${id}.json`)
        .then((response) => (this.design = response.data))
    }
  }
}
</script>

<style></style>
