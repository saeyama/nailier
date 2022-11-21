<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h1 class="text-2xl font-bold text-center py-8 md:py-10">
      ネイルデザインリスト
    </h1>
    <div class="flex justify-around mb-4 mx-2 md:mb-10 md:mx-24 lg:mx-32">
      <button
        :class="!showhandDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToHandDesigns"
        class="text-white bg-gray-800 border-0 py-2 px-10 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-24 lg:px-36 lg:py-4 lg:text-xl">
        ハンド
      </button>
      <button
        :class="!showfootDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToFootDesigns"
        class="text-white bg-gray-800 border-0 py-2 px-10 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-24 lg:px-36 lg:py-4 lg:text-xl">
        フット
      </button>
    </div>

    <select
      v-model="selectedTag"
      class="block w-5/6 md:w-1/2 mx-auto rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-3 px-3 mb-4 leading-8 transition-colors duration-200 ease-in-out">
      <option>タグで絞り込む</option>
      <option v-for="tag in nailPartTags" :key="tag">
        {{ tag }}
      </option>
    </select>

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
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-10">
              詳細
            </button>
            <button
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-10">
              編集
            </button>
            <button
              class="flex mx-auto mb-2 text-gray-600 border border-gray-600 py-2 px-8 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-1 md:px-4 md:mt-4 xl:py-2 xl:px-10">
              削除
            </button>
          </div>
        </div>
        <div>
          {{ design.createdAt }}&ensp;登録<br />
          {{ design.updatedAt }}&ensp;更新
        </div>
        <div v-for="tag in design.tags" :key="tag">
          <div class="hidden">{{ tag }}</div>
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
      selectedTag: '',
      showhandDesigns: '',
      showfootDesigns: ''
    }
  },
  computed: {
    nailPartTags() {
      return this.showhandDesigns === true
        ? this.uniqueTags(this.handDesigns)
        : this.uniqueTags(this.footDesigns)
    },
    selectedNailPartDesigns() {
      const nailPartDesigns =
        this.showhandDesigns === true ? this.handDesigns : this.footDesigns
      return this.selectedTag === ''
        ? nailPartDesigns
        : nailPartDesigns.filter((design) => {
            return design.tags.includes(this.selectedTag)
          })
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    getDesigns() {
      axios.get(`/api/designs`).then((response) => {
        response.data.designs[0].nailPart === 'hand'
          ? (this.showhandDesigns = true)
          : (this.showfootDesigns = true),
          (this.handDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'hand'
          )),
          (this.footDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'foot'
          ))
      })
    },
    switchToHandDesigns() {
      this.showhandDesigns = true
      this.showfootDesigns = false
      this.selectedTag = ''
    },
    switchToFootDesigns() {
      this.showhandDesigns = false
      this.showfootDesigns = true
      this.selectedTag = ''
    },
    uniqueTags(nailPart) {
      const nailPartTags = nailPart.map((design) => design.tags)
      const flatPartTags = [].concat(...nailPartTags)
      const deleteDuplicateTags = Array.from(new Set(flatPartTags))
      return deleteDuplicateTags
    }
  }
}
</script>

<style scoped>
.switch-nail-part-button {
  background: #ffffff;
  color: #4b5563;
  border: 1px solid #d1d5db;
}
</style>
