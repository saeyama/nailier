<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h1 class="text-xl font-bold text-center py-10">{{ design.title }}</h1>
    {{ design.nail_part }}<br />
    <div v-for="(image, index) in design.images" :key="index">
      <img :src="image" />
    </div>
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
