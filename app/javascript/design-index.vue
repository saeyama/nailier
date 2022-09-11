<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h1 class="text-xl font-bold text-center py-10">ネイルデザインリスト</h1>
    <div v-for="design in designs" :key="design.id">
      <h2>{{ design.title }}</h2>
      <img :src="design.images" />
      {{ design.created_at }}&ensp;登録<br />
      {{ design.updated_at }}&ensp;更新<br />
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      designs: []
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    getDesigns() {
      axios
        .get(`/api/designs`)
        .then((response) => (this.designs = response.data.designs))
    }
  }
}
</script>

<style></style>
