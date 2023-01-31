<template>
  <div class="text-gray-600 py-10 mx-auto">
    <h2 class="text-2xl text-center py-8 md:py-10">ネイルデザインリスト</h2>
    <div v-if="design === undefined" class="text-center">
      登録されておりません。
      <button class="main-action-btn mt-10 mb-6" @click="newDesign">
        ネイルデザインを登録
      </button>
      <button class="sub-action-btn" @click="inquiry">お問い合わせ</button>
    </div>
    <div v-else>
      <div
        class="flex justify-around gap-2 md:gap-4 mb-10 max-w-xl mx-2 sm:mx-auto">
        <button
          :class="!showhandDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToHandDesigns"
          class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
          ハンド
        </button>
        <button
          :class="!showfootDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToFootDesigns"
          class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
          フット
        </button>
      </div>
      <select
        v-model="selectedTag"
        class="block w-5/6 md:w-1/2 mx-auto rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 outline-none text-gray-700 py-3 px-3 mb-4 leading-8 duration-200 ease-in-out"
        id="design-tags">
        <option value="" selected>タグで絞り込む</option>
        <option v-for="tag in nailPartTags" :key="tag">
          {{ tag }}
        </option>
      </select>
      <div v-if="nailPartDesigns.length === 0" class="text-center mt-10">
        登録されておりません。
        <button class="main-action-btn mt-10" @click="newDesign">
          ネイルデザインを登録
        </button>
      </div>
      <div class="design md:grid md:grid-cols-3 max-w-3xl mx-auto">
        <div
          class="nailpart-design m-4 p-2 shadow-xl max-w-xs mx-auto"
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
                :src="design.image"
                alt="サムネイル画像"
                class="h-40 w-full md:h-48 md:w-56 drop-shadow-lg object-cover" />
            </div>
            <div class="md:flex md:justify-between md:my-2 md:gap-1 md:mt-4">
              <button
                class="block px-8 md:px-0 md:flex-1 text-gray-800 border border-gray-300 h-10 rounded-full shadow-lg hover:bg-gray-800 hover:text-white"
                @click="showDesign(design.id)">
                詳細
              </button>
              <button
                class="block px-8 my-2 md:my-0 md:px-0 md:flex-1 text-gray-800 border border-gray-300 h-10 rounded-full shadow-lg hover:bg-gray-800 hover:text-white"
                @click="editDesign(design.id)">
                編集
              </button>
              <button
                class="block px-8 md:px-0 md:flex-1 text-gray-800 border border-gray-300 h-10 rounded-full shadow-lg hover:bg-gray-800 hover:text-white"
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
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      design: '',
      handDesigns: [],
      footDesigns: [],
      selectedTag: '',
      showhandDesigns: '',
      showfootDesigns: '',
      id: ''
    }
  },
  computed: {
    nailPartDesigns() {
      return this.showhandDesigns === true ? this.handDesigns : this.footDesigns
    },
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
  watch: {
    design: function () {
      if (this.design !== undefined) {
        this.design.nailPart === 'ハンド'
          ? (this.showhandDesigns = true)
          : (this.showfootDesigns = true)
      }
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    getDesigns() {
      axios.get(`/api/designs`).then((response) => {
        ;(this.design = response.data.designs[0]),
          (this.handDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'ハンド'
          )),
          (this.footDesigns = response.data.designs.filter(
            (design) => design.nailPart === 'フット'
          ))
      })
    },
    newDesign() {
      window.location.href = `/designs/new`
    },
    inquiry() {
      window.location.href = `/inquiries/new`
    },
    showDesign(id) {
      window.location.href = `/designs/${id}`
    },
    editDesign(id) {
      window.location.href = `/designs/${id}/edit`
    },
    deleteDesign(id) {
      const resultOfDesignDelete = confirm(
        'この操作は取り消すことはできません。本当に削除しますか？'
      )
      if (resultOfDesignDelete) {
        axios
          .delete(`/api/designs/${id}`, {})
          .then(() => (window.location.href = '/designs'))
      } else {
        return
      }
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
