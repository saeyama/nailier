<template>
  <div class="text-gray-600 pt-10 pb-6 sm:py-10 mx-auto">
    <h1 class="text-2xl text-center py-8 md:py-10">ネイルデザインリスト</h1>
    <div v-if="design === undefined" class="text-center">
      登録されておりません。
      <button class="main-action-btn mt-10 mb-2" @click="newDesign">
        ネイルデザインを登録
      </button>
      <button class="text-btn" @click="inquiry">お問い合わせ</button>
    </div>
    <div v-else>
      <div
        class="flex justify-around gap-2 sm:gap-4 w-11/12 sm:w-3/5 mb-10 max-w-lg mx-auto">
        <button
          :class="!showHandDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToHandDesigns"
          class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
          ハンド
        </button>
        <button
          :class="!showFootDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToFootDesigns"
          class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
          フット
        </button>
      </div>
      <div class="relative w-11/12 sm:w-3/5 max-w-lg mx-auto">
        <select
          v-model="selectedTag"
          class="block w-full appearance-none rounded border border-gray-300 text-gray-700 focus:border-gray-300 outline-none p-3 mb-8"
          id="design-tags">
          <option value="" selected>タグで絞り込む</option>
          <option v-for="tag in nailPartTags" :key="tag">
            {{ tag }}
          </option>
        </select>
        <ChevronDownIcon
          class="absolute top-2/4 right-3 -translate-y-2/4 w-5 h-5 stroke-1 pointer-events-none" />
      </div>
      <div v-if="nailPartDesigns.length === 0" class="text-center mt-10">
        登録されておりません。
        <button class="main-action-btn mt-10" @click="newDesign">
          ネイルデザインを登録
        </button>
      </div>
      <div
        class="design mx-[10%] sm:mx-auto sm:grid sm:gap-x-1 gap-y-2 sm:grid-cols-2 sm:max-w-lg md:grid-cols-3 md:max-w-3xl">
        <div
          class="nailpart-design p-2 mb-4 sm:mb-0 shadow-lg max-w-sm mx-auto hover:shadow-xl"
          v-for="design in selectedNailPartDesigns"
          :key="design.id">
          <div
            @click="showDesign(design.id)"
            class="hover:opacity-80 cursor-pointer sm:w-56">
            <h2
              class="text-lg text-ellipsis overflow-hidden break-all whitespace-nowrap mt-1 mb-2">
              {{ design.title }}
            </h2>
            <div class="relative w-full pt-[85.714%] mb-2">
              <div
                v-if="!design.image"
                class="absolute top-0 w-full h-full font-light bg-slate-200 text-white flex justify-center items-center">
                no image
              </div>
              <img
                v-else
                :src="design.image"
                alt="サムネイル画像"
                class="absolute top-0 w-full h-full object-cover" />
            </div>
          </div>
          <div class="flex justify-between items-center">
            <div class="text-xs">
              {{ design.humanCreatedAt }}&ensp;登録<br />
              {{ design.humanUpdatedAt }}&ensp;更新
            </div>
            <div
              class="relative"
              @click="designChangeActionsContent(design.id)">
              <EllipsisVerticalIcon
                class="w-6 h-6 stroke-1 hover:fill-gray-700 hover:drop-shadow-lg" />
              <div
                :class="
                  showDesignChangeActionsContent &&
                  design.id === designChangeActionsContentId
                    ? 'open-change-actions-content'
                    : 'close-change-actions-content'
                "
                class="absolute -top-12 -left-14 flex justify-between gap-6 sm:gap-3 text-gray-400 cursor-pointer bg-white p-2 rounded shadow-lg">
                <PencilIcon
                  @click="editDesign(design.id)"
                  alt="編集"
                  class="w-6 h-6 stroke-1 fill-gray-100 hover:fill-gray-800 hover:drop-shadow-lg" />
                <TrashIcon
                  @click="deleteDesign(design.id)"
                  alt="削除"
                  class="w-6 h-6 stroke-1 fill-gray-100 hover:fill-gray-800 hover:drop-shadow-lg" />
              </div>
            </div>
            <!--             
            <div
              class="flex justify-between gap-6 sm:gap-3 text-gray-400 cursor-pointer">
              <PencilIcon
                @click="editDesign(design.id)"
                class="w-6 h-6 stroke-1 hover:fill-gray-700 hover:drop-shadow-lg" />
              <TrashIcon
                @click="deleteDesign(design.id)"
                class="w-6 h-6 stroke-1 hover:fill-gray-700 hover:drop-shadow-lg" />
            </div> -->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import apiClient from './packs/api-client.js'
import { EllipsisVerticalIcon } from '@heroicons/vue/24/outline'
import { ChevronDownIcon } from '@heroicons/vue/24/outline'
import { PencilIcon } from '@heroicons/vue/24/outline'
import { TrashIcon } from '@heroicons/vue/24/outline'
export default {
  components: {
    EllipsisVerticalIcon,
    ChevronDownIcon,
    PencilIcon,
    TrashIcon
  },
  data() {
    return {
      design: '',
      handDesigns: [],
      footDesigns: [],
      selectedTag: '',
      showHandDesigns: false,
      showFootDesigns: false,
      id: '',
      designChangeActionsContentId: '',
      showDesignChangeActionsContent: false
    }
  },
  computed: {
    nailPartDesigns() {
      return this.showHandDesigns ? this.handDesigns : this.footDesigns
    },
    nailPartTags() {
      return this.showHandDesigns
        ? this.uniqueTags(this.handDesigns)
        : this.uniqueTags(this.footDesigns)
    },
    selectedNailPartDesigns() {
      const nailPartDesigns = this.showHandDesigns
        ? this.handDesigns
        : this.footDesigns
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
          ? (this.showHandDesigns = true)
          : (this.showFootDesigns = true)
      }
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    async getDesigns() {
      const response = await apiClient.get(`/api/designs`)
      this.design = response.data.designs[0]
      this.handDesigns = response.data.designs.filter(
        (design) => design.nailPart === 'ハンド'
      )
      this.footDesigns = response.data.designs.filter(
        (design) => design.nailPart === 'フット'
      )
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
        apiClient
          .delete(`/api/designs/${id}`, {})
          .then(() => (window.location.href = '/designs'))
      } else {
        return
      }
    },
    switchToHandDesigns() {
      this.showHandDesigns = true
      this.showFootDesigns = false
      this.selectedTag = ''
    },
    switchToFootDesigns() {
      this.showHandDesigns = false
      this.showFootDesigns = true
      this.selectedTag = ''
    },
    uniqueTags(nailPart) {
      const nailPartTags = nailPart.map((design) => design.tags)
      const flatPartTags = [].concat(...nailPartTags)
      const deleteDuplicateTags = Array.from(new Set(flatPartTags))
      return deleteDuplicateTags
    },
    designChangeActionsContent(id) {
      this.designChangeActionsContentId = id
      this.showDesignChangeActionsContent = !this.showDesignChangeActionsContent
    }
  }
}
</script>

<style scoped>
.open-change-actions-content {
  opacity: 100;
  visibility: visible;
  transition-duration: 0.3s;
}
.close-change-actions-content {
  opacity: 0;
  visibility: hidden;
  transition-duration: 0.3s;
}

.switch-nail-part-button {
  background: #ffffff;
  color: #4b5563;
  border: 1px solid #d1d5db;
}
</style>
