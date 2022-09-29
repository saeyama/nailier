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
          v-for="image in design.images"
          :key="image.id">
          <img :src="image.url" />
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">動画</h3>
      <div class="grid grid-cols-2">
        <div
          class="w-4/6 drop-shadow-lg mb-12"
          v-for="video in design.videos"
          :key="video.id">
          <video :src="video.url" controls></video>
        </div>
      </div>
      <div class="grid grid-cols-2">
        <div
          class="w-4/6 drop-shadow-lg mb-12"
          v-for="youtube_video in design.youtube_videos"
          :key="youtube_video.id">
          <youtube
            :video-id="youtube_video.access_code"
            class="w-full h-full" />
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
      <div class="mb-8">
        {{ design.description }}
      </div>
      <div class="mb-12 flex justify-start">
        <div
          v-for="tag in design.tags"
          :key="tag.id"
          class="border border-gray-800 mr-4 p-2 rounded">
          {{ tag.name }}&nbsp;
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Vue from 'vue'
import VueYoutube from 'vue-youtube'
Vue.use(VueYoutube)
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
