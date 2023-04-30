<template>
  <div class="text-gray-600 py-10 mb-4">
    <div class="w-11/12 md:w-3/4 mx-auto">
      <h1 class="design-title text-2xl text-center py-2">{{ design.title }}</h1>
      <div class="design-nailpart text-sm md:text-base text-center pb-10">
        {{ design.nailPart }}
      </div>
      <div class="design-images">
        <h2 class="text-lg mb-2">画像</h2>
        <div
          class="text-sm ml-0.5 mb-6"
          v-if="!design.images || !design.images.length">
          登録されている画像はありません。
        </div>
        <div v-else>
          <div class="text-sm mb-2">画像をクリックすると拡大できます。</div>
          <div class="grid grid-cols-3 gap-1 md:grid-cols-4 mb-4">
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
          class="text-sm ml-0.5 mb-6"
          v-if="design.youtubeVideos.length === 0">
          登録されているYouTube動画はありません。
        </div>
        <div v-else>
          <span class="text-sm ml-0.5">
            再生したい動画をクリックしてからYouTubeの文字をクリックすると、アプリもしくはWEBブラウザに移動します。
          </span>
          <div class="grid grid-cols-2 md:grid-cols-3 gap-1 mb-4">
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
        <div class="text-sm ml-0.5 mb-6" v-if="design.colors.length === 0">
          登録されているカラーはありません。
        </div>
        <div v-else>
          <div class="grid grid-cols-6 mb-6 md:grid-cols-12 ml-1">
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
        <div class="text-sm ml-0.5 mb-6" v-if="design.parts.length === 0">
          登録されているパーツはありません。
        </div>
        <div v-else>
          <div class="mb-8 w-4/6 md:2/6">
            <div v-for="part in design.parts" :key="part" class="mb-4 ml-0.5">
              <div class="flex justify-between items-center">
                <div>
                  <div class="mr-4">
                    <span class="font-semibold md:w-48 md:inline-block">
                      {{ part.name }}
                    </span>
                    <br class="md:hidden" />
                    <span class="mr-4">{{ part.size }}</span>
                    <span>{{ part.quantity }}個</span>
                  </div>
                </div>
                <div v-if="!part.hexNumber" class="w-8 h-8 mt-2 md:mt-0"></div>
                <div
                  v-else
                  :style="colorShowHexNumber(part.hexNumber)"
                  class="rounded-full shadow-md w-8 h-8 mt-2 md:mt-0">
                  <div class="hidden">{{ part.hexNumber }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="design-description">
        <h2 class="text-lg mb-1">調べた内容・メモ</h2>
        <div class="text-sm ml-0.5 mb-6" v-if="design.description.length === 0">
          登録されているメモはありません。
        </div>
        <div v-else>
          <div
            v-text="design.description"
            class="whitespace-pre-wrap mb-8 text-sm border border-gray-300 px-2 py-1 rounded"></div>
        </div>
      </div>
      <div class="design-tags">
        <h2 class="text-lg mb-2">タグ</h2>
        <div class="text-sm ml-0.5 mb-6" v-if="design.tags.length === 0">
          登録されているタグはありません。
        </div>
        <div v-else>
          <div class="mb-12 mr-4 py-1 rounded flex justify-start items-center">
            <div
              v-for="tag in design.tags"
              :key="tag.id"
              class="font-bold border border-gray-300 mr-2 px-2 py-1 rounded">
              {{ tag.name }}
            </div>
          </div>
        </div>
      </div>
      <button class="main-action-btn mb-2" @click="editDesign">
        ネイルデザインを編集
      </button>
      <button class="delete-btn mb-8" @click="deleteDesign">
        ネイルデザインを削除
      </button>
      <button class="sub-action-btn" @click="indexDesign">
        ネイルデザイン一覧
      </button>
    </div>
  </div>
</template>

<script>
import apiClient from './packs/api-client.js'
import VueEasyLightbox from 'vue-easy-lightbox'
import { YoutubeVue3 } from 'youtube-vue3'
export default {
  components: {
    VueEasyLightbox,
    YoutubeVue3
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
    editDesign() {
      window.location.href = `/designs/${this.design.id}/edit`
    },
    deleteDesign() {
      const resultOfDesignDelete = confirm(
        'この操作は取り消すことはできません。本当に削除しますか？'
      )
      if (resultOfDesignDelete) {
        apiClient
          .delete(`/api/designs/${this.design.id}`, {})
          .then(() => (window.location.href = '/designs'))
      } else {
        return
      }
    },
    indexDesign() {
      window.location.href = `/designs`
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
