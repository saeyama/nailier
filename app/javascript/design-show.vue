<template>
  <div>
    <h1 class="design-title page-content-title">{{ design.title }}</h1>
    <div class="grid gap-y-12 sm:gap-y-10">
      <div
        class="design-nailpart w-20 h-10 flex justify-center items-center rounded mx-auto bg-gray-800 text-white">
        {{ design.nailPart }}
      </div>
      <div class="design-images">
        <h2 class="text-lg mb-2">画像</h2>
        <div
          class="text-sm ml-0.5 mb-2 sm:mb-6"
          v-if="!design.images || !design.images.length">
          登録されている画像はありません。
        </div>
        <div v-else>
          <div class="text-sm mb-2 flex justify-start items-center gap-1">
            <InformationCircleIcon class="w-6 h-6" />
            画像をクリックすると拡大できます。
          </div>
          <div class="grid grid-cols-3 gap-1 md:grid-cols-4">
            <div
              class="drop-shadow-lg mb-2 md:mb-8"
              v-for="(image, index) in design.images"
              :key="index"
              @click="showImages(index)">
              <img
                :src="image"
                alt="登録画像"
                class="mt-2 aspect-[4/3] w-full object-cover" />
            </div>
          </div>
          <vue-easy-lightbox
            :visible="visible"
            :imgs="design.images"
            :index="index"
            @hide="hideImagsShowHandle">
          </vue-easy-lightbox>
        </div>
      </div>
      <div class="design-youtubevideos">
        <h2 class="text-lg mb-2">YouTube動画</h2>
        <div
          class="text-sm ml-0.5 mb-2 sm:mb-6"
          v-if="design.youtubeVideos.length === 0">
          登録されているYouTube動画はありません。
        </div>
        <div v-else>
          <div class="text-sm mb-2">
            <h3 class="flex justify-start items-center gap-1">
              <InformationCircleIcon class="w-6 h-6" />
              動画の再生方法
            </h3>
            <p class="text-xs">
              再生したい動画をクリックしてから<br class="sm:hidden" />
              右下のYouTubeの文字をクリックします。<br />
              アプリもしくはWEBブラウザに移動します。
            </p>
          </div>
          <div class="grid grid-cols-2 md:grid-cols-3 gap-1">
            <div
              v-for="youtubeVideo in design.youtubeVideos"
              :key="youtubeVideo.id"
              class="drop-shadow-lg mb-2 md:mb-8">
              <div class="hidden">{{ youtubeVideo.accessCode }}</div>
              <div class="w-full aspect-video">
                <YoutubeVue3
                  :videoid="youtubeVideo.accessCode"
                  :autoplay="0"
                  class="mt-2 w-full h-full youtubevideo-accesscode">
                </YoutubeVue3>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="design-colors">
        <h2 class="text-lg mb-2">カラー</h2>
        <div
          class="text-sm ml-0.5 mb-2 sm:mb-6"
          v-if="design.colors.length === 0">
          登録されているカラーはありません。
        </div>
        <div v-else>
          <div class="grid grid-cols-6 md:grid-cols-12">
            <div
              v-for="color in design.colors"
              :key="color.id"
              :style="colorShowHexNumber(color.hexNumber)"
              class="w-8 h-8 rounded-full drop-shadow-lg mb-2 md:mb-8">
              <div class="hidden">{{ color.lame }}</div>
              <div class="hidden">{{ color.hexNumber }}</div>
              <div v-if="color.lame" class="relative">
                <img
                  src="~lame.png"
                  alt="ラメ"
                  class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
              </div>
              <div v-else-if="!color.lame"></div>
            </div>
          </div>
        </div>
      </div>
      <div class="design-parts">
        <h2 class="text-lg mb-2">パーツ</h2>
        <div
          class="text-sm ml-0.5 mb-2 sm:mb-6"
          v-if="design.parts.length === 0">
          登録されているパーツはありません。
        </div>
        <div v-else class="mb-2 sm:mb-8">
          <div
            v-for="part in design.parts"
            :key="part"
            class="mb-6 last:mb-0 sm:mr-28">
            <div
              class="flex flex-wrap justify-start items-center gap-x-20 sm:gap-x-12">
              <div class="w-full sm:flex-1">
                <div class="flex justify-start items-center gap-1.5">
                  <SparklesIcon class="w-4 h-4 stroke-1 text-gray-400" />
                  {{ part.name }}
                </div>
              </div>
              <div class="flex-1 sm:flex-none ml-6 sm:ml-0">
                {{ part.size }}
              </div>
              <div class="flex-1 sm:flex-none">{{ part.quantity }}個</div>
              <div v-if="!part.hexNumber" class="w-8 h-8"></div>
              <div
                v-else
                :style="colorShowHexNumber(part.hexNumber)"
                class="rounded-full shadow-md w-8 h-8">
                <div class="hidden">{{ part.hexNumber }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="design-description">
        <h2 class="text-lg mb-2">調べた内容・メモ</h2>
        <div
          class="text-sm ml-0.5 mb-2 sm:mb-6"
          v-if="design.description.length === 0">
          登録されているメモはありません。
        </div>
        <div v-else>
          <div
            v-text="design.description"
            class="whitespace-pre-wrap px-2 py-1 h-20 resize-y overflow-auto text-sm border border-gray-300 rounded mb-2 sm:mb-8"></div>
        </div>
      </div>
      <div class="design-tags">
        <h2 class="text-lg mb-2">タグ</h2>
        <div
          class="text-sm ml-0.5 mb-16 sm:mb-20"
          v-if="design.tags.length === 0">
          登録されているタグはありません。
        </div>
        <div v-else class="mb-12 sm:mb-16">
          <div class="flex flex-wrap mt-2 gap-x-6 gap-y-2">
            <div v-for="tag in design.tags" :key="tag.id">
              <div class="text-lg flex justify-start items-end gap-1">
                <TagIcon class="w-6 h-6 text-gray-300" />
                {{ tag.name }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <design-link :id="design.id" link="design-edit" class="main-action-btn my-2"
      >ネイルデザインを編集</design-link
    >
    <design-delete :id="design.id" class="text-btn mb-8"
      >ネイルデザインを削除</design-delete
    >
    <design-link :id="design.id" link="design-index" class="sub-action-btn"
      >ネイルデザイン一覧</design-link
    >
  </div>
</template>

<script>
import apiClient from './packs/api-client.js'
import DesignLink from './components/design-link.vue'
import DesignDelete from './components/design-delete.vue'
import VueEasyLightbox from 'vue-easy-lightbox'
import { YoutubeVue3 } from 'youtube-vue3'
import { InformationCircleIcon } from '@heroicons/vue/24/outline'
import { SparklesIcon } from '@heroicons/vue/24/outline'
import { TagIcon } from '@heroicons/vue/24/outline'
export default {
  components: {
    DesignLink,
    DesignDelete,
    VueEasyLightbox,
    YoutubeVue3,
    InformationCircleIcon,
    SparklesIcon,
    TagIcon
  },
  data() {
    return {
      design: {
        id: '',
        title: '',
        nailPart: '',
        description: '',
        images: [],
        youtubeVideos: [],
        colors: [],
        parts: [],
        tags: []
      },
      visible: false,
      index: 0
    }
  },
  computed: {
    colorShowHexNumber: () => (hexNumber) => ({
      'background-color': hexNumber
    })
  },
  mounted() {
    this.getDesign()
  },
  methods: {
    async getDesign() {
      const url = location.pathname.split('/')
      const id = url[url.length - 1]
      const response = await apiClient.get(`/api/designs/${id}.json`)
      this.design = response.data
      this.design.images =
        response.data.images !== null
          ? response.data.images.map((imageData) => imageData.url)
          : []
    },
    showImages(index) {
      this.index = index
      this.visible = true
    },
    hideImagsShowHandle() {
      this.visible = false
    }
  }
}
</script>
