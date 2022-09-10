<template>
  <div>
    <h1 class="text-red-500 text-center">テスト</h1>
    <div v-for="design in designs" :key="design.id">
      <h2>{{ design.title }}</h2>
      {{ design.created_at }}&ensp;登録<br />
      {{ design.updated_at }}&ensp;更新
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
