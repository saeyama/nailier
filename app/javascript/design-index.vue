<template>
  <div class="-mb-16 sm:-mb-20">
    <h1 class="page-content-title">ネイルデザインリスト</h1>
    <div v-if="design === undefined" class="text-center">
      登録されておりません。
    </div>
    <div v-else>
      <div class="flex justify-around mb-2 w-44 mx-auto h-11">
        <button
          :class="!showHandDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToHandDesigns"
          class="flex-1 rounded-l text-white bg-gray-800 shadow-lg">
          ハンド
        </button>
        <button
          :class="!showFootDesigns ? 'switch-nail-part-button' : ''"
          @click="switchToFootDesigns"
          class="flex-1 rounded-r text-white bg-gray-800 shadow-lg">
          フット
        </button>
      </div>
      <div class="relative w-44 mx-auto mb-10 border-b border-gray-200">
        <select
          v-model="selectedTag"
          class="block w-full text-sm appearance-none bg-transparent text-gray-700 outline-none py-2 pl-2 pr-6 text-ellipsis overflow-hidden break-all whitespace-nowrap"
          id="design-tags">
          <option value="" selected>タグで絞り込む</option>
          <option v-for="tag in nailPartTags" :key="tag">
            {{ tag }}
          </option>
        </select>
        <ChevronDownIcon
          class="absolute top-2/4 right-2 -translate-y-2/4 w-4 h-4 stroke-1 text-gray-500 pointer-events-none" />
      </div>
      <div v-if="nailPartDesigns.length === 0" class="text-center mt-10">
        登録されておりません。
      </div>
      <div
        class="design mx-[10%] sm:mx-auto sm:grid sm:gap-x-1 gap-y-2 sm:grid-cols-2 sm:max-w-lg md:grid-cols-3 md:max-w-3xl">
        <div
          class="nailpart-design p-2 mb-4 last:mb-0 sm:mb-0 shadow-lg max-w-sm mx-auto hover:shadow-xl"
          v-for="design in selectedNailPartDesigns"
          :key="design.id">
          <design-link :id="design.id" link="design-show">
            <div class="hover:opacity-80 cursor-pointer sm:w-56">
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
          </design-link>
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
                <design-link :id="design.id" link="design-edit">
                  <PencilIcon
                    @click="editDesign(design.id)"
                    class="w-6 h-6 stroke-1 fill-gray-100 hover:fill-gray-800 hover:drop-shadow-lg" />
                </design-link>
                <design-delete :id="design.id">
                  <TrashIcon
                    class="w-6 h-6 stroke-1 fill-gray-100 hover:fill-gray-800 hover:drop-shadow-lg" />
                </design-delete>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="sticky bottom-0 py-10 bg-white/60">
      <design-link
        link="design-new"
        class="new-design-link-btn main-action-btn">
        ネイルデザインを登録
      </design-link>
    </div>
  </div>
</template>

<script>
import apiClient from './packs/api-client.js'
import DesignLink from './components/design-link.vue'
import DesignDelete from './components/design-delete.vue'
import { EllipsisVerticalIcon } from '@heroicons/vue/24/outline'
import { ChevronDownIcon } from '@heroicons/vue/24/outline'
import { PencilIcon } from '@heroicons/vue/24/outline'
import { TrashIcon } from '@heroicons/vue/24/outline'
export default {
  components: {
    DesignLink,
    DesignDelete,
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
  border: 1px solid #e5e7eb;
}
</style>
