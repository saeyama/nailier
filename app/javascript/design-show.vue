<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <div class="mx-4">
      <h2 class="text-2xl font-bold text-center py-2">{{ design.title }}</h2>
      <div class="text-sm text-center underline underline-offset-2 pb-10">
        ネイルデザインを複製
      </div>
      <div class="text-lg font-bold mb-12">{{ design.nail_part }}</div>
      <h3 class="text-lg font-bold mb-4">画像</h3>
      <div class="grid grid-cols-4">
        <div
          class="w-5/6 drop-shadow-lg mb-12"
          v-for="(image, index) in design.images"
          :key="index">
          <img :src="image" />
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">カラー</h3>
      <div class="grid grid-cols-6 mb-12">
        <div v-for="color in design.colors" :key="color.id">
          {{ color.hex_number }}
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">パーツ</h3>
      <div class="mb-12">
        <div v-for="part in design.parts" :key="part.id">
          {{ part.name }}&nbsp; {{ part.size }}&nbsp;
          {{ part.quantity }}個&nbsp;
          {{ part.hex_number }}
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">調べた内容・メモ</h3>
      {{ design.description }}
    </div>
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
