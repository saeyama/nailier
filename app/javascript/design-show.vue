<template>
  <div class="container text-gray-600 py-10 mx-auto mb-4">
    <div class="w-11/12 md:w-3/4 mx-auto">
      <h2 class="text-2xl font-bold text-center py-2">{{ design.title }}</h2>
      <div class="text-sm text-center underline underline-offset-2 pb-10">
        ネイルデザインを複製
      </div>
      <div class="text-lg font-bold mb-12">{{ design.nailPart }}</div>
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
      <div class="grid grid-cols-2 mb-2">
        <div
          class="w-2/6 drop-shadow-lg mb-12"
          v-for="video in design.videos"
          :key="video.id">
          <video :src="video.url" controls></video>
        </div>
      </div>
      <div class="grid grid-cols-2">
        <div
          class="w-11/12 drop-shadow-lg mb-12"
          v-for="youtubeVideo in design.youtubeVideos"
          :key="youtubeVideo.id">
          <youtube :video-id="youtubeVideo.accessCode" class="w-full h-full" />
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">カラー</h3>
      <div class="flex space-x-12 mb-8">
        <div
          v-for="color in design.colors"
          :key="color.id"
          :style="colorShowHexNumber(color.hexNumber)"
          class="w-8 h-8 rounded-full shadow-md shadow-gray-500/30">
          <div v-if="color.lame === true" class="relative">
            <img
              src="~lame.png"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="color.lame === false"></div>
        </div>
      </div>
      <h3 class="text-lg font-bold mb-4">パーツ</h3>
      <div class="mb-4">
        <div
          v-for="part in design.parts"
          :key="part"
          class="flex items-center mb-2 mr-4 space-x-8">
          <div class="flex items-center w-full">
            <div class="w-3/4">
              {{ part.name }}&nbsp; {{ part.size }}&nbsp;
              {{ part.quantity }}個&nbsp;
            </div>
            <div v-if="!part.hexNumber" class="w-8 h-8"></div>
            <div
              v-else
              :style="colorShowHexNumber(part.hexNumber)"
              class="rounded-full shadow-md shadow-gray-500/30 w-8 h-8"></div>
          </div>
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
          class="border border-gray-300 mr-4 px-2 py-1 rounded">
          {{ tag.name }}
        </div>
      </div>
      <button
        class="flex mx-auto mb-2 text-white bg-gray-800 border-0 py-2 px-8 rounded-full shadow-lg shadow-gray-500/30 md:px-20"
        @click="updateDesign">
        ネイルデザインを編集
      </button>
      <button
        class="block mx-auto underline mb-8 text-bg-gray-600 hover:text-bg-gray-600"
        @click="deleteDesign">
        ネイルデザインを削除
      </button>
      <button
        class="flex mx-auto text-bg-gray-800 white border border-gray-800 py-2 px-8 rounded-full shadow-lg shadow-gray-500/30 md:px-20"
        @click="updateDesign">
        ネイルデザイン一覧
      </button>
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
  computed: {
    colorShowHexNumber() {
      return function (hexNumber) {
        return {
          'background-color': hexNumber
        }
      }
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
    },
    deleteDesign() {
      axios
        .delete(`/api/designs/${this.design.id}`, {})
        .then(() => (window.location.href = '/designs'))
    }
  }
}
</script>

<style></style>
