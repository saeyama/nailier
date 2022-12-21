<template>
  <div class="text-gray-600 py-10 mx-auto">
    <h1 class="text-2xl text-center py-8 md:py-10">ネイルデザインリスト</h1>
    <div
      class="flex justify-around gap-2 md:gap-4 mb-10 mx-[4%] sm:mx-[8%] md:mx-[12%] lg:mx-[20%]">
      <button
        :class="!showhandDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToHandDesigns"
        class="flex-1 text-white bg-gray-800 border-0 py-2 rounded-full shadow-lg">
        ハンド
      </button>
      <button
        :class="!showfootDesigns ? 'switch-nail-part-button' : ''"
        @click="switchToFootDesigns"
        class="flex-1 text-white bg-gray-800 border-0 py-2 rounded-full shadow-lg">
        フット
      </button>
    </div>
    <select
      v-model="selectedTag"
      class="block w-5/6 md:w-1/2 mx-auto rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 outline-none text-gray-700 py-3 px-3 mb-4 leading-8 duration-200 ease-in-out">
      <option value="" selected>タグで絞り込む</option>
      <option v-for="tag in nailPartTags" :key="tag">
        {{ tag }}
      </option>
    </select>
    <div class="md:grid md:grid-cols-3 max-w-3xl mx-auto">
      <div
        class="m-4 p-2 shadow-xl max-w-xs mx-auto"
        v-for="design in selectedNailPartDesigns"
        :key="design.id">
        <h2 class="text-lg font-bold">{{ design.title }}</h2>
        <div class="flex gap-2 justify-center items-center md:block mb-1">
          <div v-if="!design.image" class="flex-1">
            <div
              class="h-40 w-full md:h-48 md:w-56 text-lg leading-[10rem] md:leading-[12rem] bg-slate-200 drop-shadow-lg text-white text-center mx-auto md:text-2xl">
              no image
            </div>
          </div>
          <div v-else class="flex-1">
            <img
              class="h-40 w-full md:h-48 md:w-56 drop-shadow-lg object-cover"
              :src="design.image" />
          </div>
          <div class="md:flex md:justify-between md:my-2 md:gap-1 md:mt-4">
            <button
              class="block px-8 md:px-0 md:flex-1 text-gray-800 border border-gray-300 shadow-md py-2 hover:bg-gray-800 hover:text-white rounded-full md:py-1"
              @click="showDesign(design.id)">
              詳細
            </button>
            <button
              class="block px-8 my-2 md:my-0 md:px-0 md:flex-1 text-gray-800 border border-gray-300 shadow-md py-2 hover:bg-gray-800 hover:text-white rounded-full md:py-1"
              @click="editDesign(design.id)">
              編集
            </button>
            <button
              class="block px-8 md:px-0 md:flex-1 text-gray-800 border border-gray-300 shadow-md py-2 hover:bg-gray-800 hover:text-white rounded-full md:py-1"
              @click="deleteDesign(design.id)">
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
      showfootDesigns: '',
      id: ''
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
        response.data.designs[0].nailPart === 'ハンド'
          ? (this.showhandDesigns = true)
          : (this.showfootDesigns = true),
          (this.handDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'ハンド'
          )),
          (this.footDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'フット'
          ))
      })
    },
    showDesign(id) {
      window.location.href = `/designs/${id}`
    },
    editDesign(id) {
      window.location.href = `/designs/${id}/edit`
    },
    deleteDesign(id) {
      axios
        .delete(`/api/designs/${id}`, {})
        .then(() => (window.location.href = '/designs'))
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
