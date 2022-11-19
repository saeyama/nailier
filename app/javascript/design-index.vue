<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h1 class="text-2xl font-bold text-center py-10">ネイルデザインリスト</h1>
    <div class="flex justify-around mb-4 mx-2 md:mx-4 lg:mx-48">
      <button
        :class="!showhandDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToHandDesigns"
        class="text-white bg-gray-800 border-0 py-2 px-10 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-24 lg:px-40 lg:py-4 lg:text-xl">
        ハンド
      </button>
      <button
        :class="!showfootDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToFootDesigns"
        class="text-white bg-gray-800 border-0 py-2 px-10 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-24 lg:px-40 lg:py-4 lg:text-xl">
        フット
      </button>
    </div>
    <div class="md:grid md:grid-cols-3">
      <div
        class="m-4 p-2 shadow-xl md:max-w-md"
        v-for="design in selectedNailPartDesigns"
        :key="design.id">
        <div class="flex justify-between items-center m-2">
          <h2 class="text-lg font-bold">{{ design.title }}</h2>
          <div class="underline underline-offset-2 text-xs xl:text-sm">
            ネイルデザインを複製
          </div>
        </div>
        <div class="flex justify-center items-center md:block">
          <div class="w-1/2 md:w-full">
            <img
              class="w-5/6 drop-shadow-lg mx-auto md:w-3/4"
              :src="design.image" />
          </div>
          <div
            class="w-1/2 justify-between items-center md:flex md:justify-between md:w-full md:mb-2">
            <button
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-12">
              詳細
            </button>
            <button
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-12">
              編集
            </button>
            <button
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-12">
              削除
            </button>
          </div>
        </div>
        <div>
          {{ design.createdAt }}&ensp;登録<br />
          {{ design.updatedAt }}&ensp;更新
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      handDesigns: [],
      footDesigns: [],
      showhandDesigns: true,
      showfootDesigns: false
    }
  },
  computed: {
    selectedNailPartDesigns() {
      return this.showhandDesigns === true ? this.handDesigns : this.footDesigns
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    getDesigns() {
      axios.get(`/api/designs`).then((response) => {
        ;(this.handDesigns = response.data.designs.filter(
          (design) => design.nailPart === 'hand'
        )),
          (this.footDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'foot'
          ))
      })
    },
    switchToHandDesigns() {
      ;(this.showhandDesigns = true), (this.showfootDesigns = false)
    },
    switchToFootDesigns() {
      ;(this.showhandDesigns = false), (this.showfootDesigns = true)
    }
  }
}
</script>

<style>
.switch-nail-part-button {
  background: #ffffff;
  color: #4b5563;
  border: 1px solid #d1d5db;
}
</style>
