<template>
  <div class="container text-gray-600 py-10 mx-auto mb-4">
    <h2 class="text-2xl font-bold text-center py-10">ネイルデザインを編集</h2>
    <div class="w-11/12 md:w-3/4 mx-auto">
      <div class="p-2 w-full text-lg">
        <lable>タイトル</lable>
        <input
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          type="text"
          name="title"
          placeholder="入力してください"
          v-model="design.title" />
      </div>
      <div class="p-2 w-full text-lg">
        <label>ハンド</label>&nbsp;
        <input
          class="w-4 h-4"
          type="radio"
          name="nail_part"
          value="hand"
          v-model="design.nailPart" />&emsp; <label>フット</label>&nbsp;
        <input
          class="w-4 h-4"
          type="radio"
          name="nail_part"
          value="foot"
          v-model="design.nailPart" />
      </div>
      <div class="p-2 w-full text-lg">
        <lable>画像&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="image"
          multiple="multiple"
          accept="image/*"
          @change="uploadFiles"
          class="text-sm w-64 md:text-lg md:w-full" />
        <draggable
          v-model="design.images"
          draggable=".item"
          class="grid grid-cols-4 mb-2">
          <div
            class="item w-full mt-4 relative h-36"
            v-for="(image, index) in design.images"
            :key="index">
            <img :src="image.url" class="absolute z-0 h-32" />
            <div
              @click="deleteImage(index)"
              class="cursor-pointer absolute z-10 top-1 right-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-6 h-6 stroke-white rounded-md bg-gray-800 shadow-lg">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M6 18L18 6M6 6l12 12" />
              </svg>
            </div>
          </div>
        </draggable>
      </div>
      <div class="p-2 w-full text-lg">
        <lable>動画&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="video"
          multiple="multiple"
          accept="video/*"
          @change="uploadFiles"
          class="text-sm w-64 md:text-lg md:w-full" />
        <div class="w-4/6 grid grid-cols-2 mb-2">
          <div
            class="w-full mt-4 relative h-36"
            v-for="video in design.videos"
            :key="video">
            <video class="h-32 absolute z-0">
              <source :src="video.url" type="video/mp4" />
            </video>
            <div
              @click="deleteVideo(url)"
              class="cursor-pointer absolute z-10 top-1 right-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-6 h-6 stroke-white rounded-md bg-gray-800 shadow-lg">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M6 18L18 6M6 6l12 12" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <div class="p-2 w-full">
        <input
          type="text"
          name="youtube_video"
          placeholder="youtubeのURL"
          class="md:w-5/6 rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          v-model="youtubeVideo.url" />
        <button
          @click="youtubeVideoData"
          class="font-bold mx-auto my-2 text-white bg-gray-800 border-0 py-2 px-6 rounded-full shadow-lg shadow-gray-500/30">
          登録
        </button>
      </div>
      <div class="grid grid-cols-2 gap-8 mb-2">
        <div
          v-for="(youtubeVideo, index) in design.youtubeVideos"
          :key="index"
          class="h-32 md:h-48">
          <div class="relative">
            <youtube
              :video-id="youtubeVideo.accessCode"
              class="w-32 h-28 md:w-64 md:h-48 absolute z-0 left-2">
            </youtube>
            <div
              @click="deleteYoutubeVideo(index)"
              class="cursor-pointer absolute z-10 top-1 -right-4 md:right-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-6 h-6 stroke-white rounded-md bg-gray-800 shadow-lg">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M6 18L18 6M6 6l12 12" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">カラー・パーツ</h3>
      <ul class="mb-4">
        <li>
          <a
            href="https://www.nailtat.com/"
            class="external-link bg-no-repeat bg-right pl-2 pr-6 underline hover:text-gray-400"
            target="_blank">
            TATから探す
          </a>
        </li>
        <li>
          <a
            href="https://www.nail-partner.com/"
            class="external-link bg-no-repeat bg-right pl-2 pr-6 underline hover:text-gray-400"
            target="_blank">
            ネイルパートナーから探す
          </a>
        </li>
      </ul>
      <h3 class="p-2 text-lg">
        カラーイメージを登録する
        <input type="checkbox" @click="showColorContent" />
      </h3>
      <div
        class="mb-4 w-full text-lg border border-gray-300 rounded"
        v-show="colorContent">
        <div class="text-sm my-4 pl-2 md:pl-4 md:text-lg">
          <lable>ラメ</lable>&emsp; なし&nbsp;
          <input type="radio" v-model="color.lame" :value="false" />&emsp;
          あり&nbsp;
          <input type="radio" v-model="color.lame" :value="true" />
        </div>
        <div class="flex justify-around mb-4 md:mx-4 lg:mx-20">
          <button
            :class="!showColorPicker ? 'switch-color-button' : ''"
            @click="switchToColorPicker"
            class="text-white text-sm bg-gray-800 border-0 py-2 px-2 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-16">
            カラーピッカー
          </button>
          <button
            :class="!showColorPalette ? 'switch-color-button' : ''"
            @click="switchToColorPalette"
            class="text-white text-sm bg-gray-800 border-0 py-2 px-2 rounded-full shadow-lg shadow-gray-500/30 md:text-lg md:px-16">
            カラーパレット
          </button>
        </div>
        <div v-show="showColorPicker">
          <div v-if="colorLameStyle" class="relative h-64">
            <img
              src="~color-picker-lame.png"
              class="color-picker-img absolute z-10 pointer-events-none" />
            <chrome-picker
              class="absolute z-0 color-picker-img"
              :value="color.pickerHexNumber"
              v-model="color.pickerHexNumber">
            </chrome-picker>
          </div>
          <div v-else class="h-64 mb-3">
            <chrome-picker
              class="mx-auto"
              :value="color.pickerHexNumber"
              v-model="color.pickerHexNumber">
            </chrome-picker>
          </div>
        </div>
        <div v-show="showColorPalette">
          <div v-if="colorLameStyle" class="relative h-80">
            <ul
              class="grid gap-2 place-items-center grid-cols-5 border border-gray-300 m-2 p-4">
              <li
                v-for="(hexNumber, index) in colorPaletteHexNumbers"
                :key="index"
                :style="colorShowHexNumber(hexNumber)"
                class="w-8 h-8 rounded-full cursor-pointer shadow-md shadow-gray-500/30">
                <img
                  src="~lame.png"
                  class="w-8 h-8 rounded-full opacity-80 absolute z-10 pointer-events-none" />
                <input
                  type="radio"
                  v-model="color.paletteHexNumber"
                  :value="hexNumber"
                  class="checkbox appearance-none focus:opacity-100 focus:ring-2 focus:ring-offset-2 focus:ring-gray-600 focus:outline-none rounded-full cursor-pointer w-8 h-8 checked:border-none" />
              </li>
            </ul>
          </div>
          <div v-else class="h-80 mb-3">
            <ul class="grid gap-2 place-items-center grid-cols-5 m-2 p-4">
              <li
                v-for="(hexNumber, index) in colorPaletteHexNumbers"
                :key="index"
                :style="colorShowHexNumber(hexNumber)"
                class="w-8 h-8 rounded-full shadow-md shadow-gray-500/30">
                <input
                  type="radio"
                  v-model="color.paletteHexNumber"
                  :value="hexNumber"
                  class="checkbox appearance-none focus:opacity-100 focus:ring-2 focus:ring-offset-2 focus:ring-gray-600 focus:outline-none rounded-full cursor-pointer w-8 h-8 checked:border-none" />
              </li>
            </ul>
          </div>
        </div>
        <button
          class="flex font-bold mx-auto my-8 text-white bg-gray-800 border-0 py-2 px-24 rounded-full shadow-lg shadow-gray-500/30 md:px-36"
          @click="colorData">
          決定
        </button>
      </div>
      <div class="flex space-x-12 mb-2">
        <div
          v-for="(color, index) in design.colors"
          :key="index"
          :style="colorShowHexNumber(color.hexNumber)"
          class="w-8 h-8 rounded-full shadow-md shadow-gray-500/30">
          <div v-if="color.lame == true" class="relative">
            <img
              src="~lame.png"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="color.lame == false"></div>
          <div @click="deleteColor(index)" class="ml-10 cursor-pointer mt-1">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-6 h-6">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M6 18L18 6M6 6l12 12" />
            </svg>
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">
        パーツ内容を登録する
        <input type="checkbox" @click="showPartContent" />
      </h3>
      <div
        class="p-2 md:p-4 mb-4 w-full md:px-8 text-lg border border-gray-300 rounded"
        v-show="partContent">
        <input
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          type="text"
          name="name"
          placeholder="パーツ名を入力してください。"
          v-model="part.name" />
        <div class="my-4 px-2">
          <button
            v-for="(candidateName, index) in part.candidateNamesList.name"
            :key="index"
            @click="selectPartName(index)"
            class="cursor-pointer mr-4 my-1 hover:font-bold text-base">
            {{ candidateName }}
          </button>
        </div>
        <input
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          type="text"
          name="size"
          placeholder="大きさを入力してください。"
          v-model="part.size" />
        <div class="my-4 px-2">
          <button
            v-for="(candidateSize, index) in part.candidateNamesList.size"
            :key="index"
            @click="selectPartSize(index)"
            class="cursor-pointer mr-4 my-1 hover:font-bold">
            {{ candidateSize }}
          </button>
        </div>
        <div
          class="flex justify-between items-center mb-6 rounded border border-gray-300 px-4 py-2">
          <label>個数</label>
          <input
            class="rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-4 leading-8 transition-colors duration-200 ease-in-out w-20"
            type="number"
            min="0"
            onkeypress="return (event.charCode == 8 || event.charCode == 46) ? null : event.charCode >= 48 && event.charCode <= 57"
            name="quantity"
            placeholder="0"
            v-model="part.quantity" />
        </div>

        <div
          class="flex justify-between items-center w-full rounded border border-gray-300 px-4 py-2">
          <label>カラー</label>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-6 h-6"
            :class="{ 'rotate-to-open': partColorContent }"
            @click="showPartColorContent">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M8.25 4.5l7.5 7.5-7.5 7.5" />
          </svg>
        </div>
        <div
          class="rounded-b-lg border border-gray-300 py-2"
          v-show="partColorContent">
          <ul class="grid gap-2 place-items-center grid-cols-5 m-1">
            <li
              v-for="(hexNumber, index) in colorPaletteHexNumbers"
              :key="index"
              :style="colorShowHexNumber(hexNumber)"
              class="w-8 h-8 rounded-full cursor-pointer shadow-md shadow-gray-500/30">
              <input
                type="radio"
                v-model="part.hexNumber"
                :value="hexNumber"
                class="checkbox appearance-none focus:opacity-100 focus:ring-2 focus:ring-offset-2 focus:ring-gray-600 focus:outline-none rounded-full cursor-pointer w-8 h-8 checked:border-none" />
            </li>
          </ul>
        </div>
        <button
          class="flex font-bold mx-auto my-8 text-white bg-gray-800 border-0 py-2 px-24 rounded-full shadow-lg shadow-gray-500/30 md:px-36"
          @click="partData">
          決定
        </button>
      </div>
      <div class="mb-4">
        <div
          v-for="(part, index) in design.parts"
          :key="index"
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
          <div @click="deletePart(index)" class="cursor-pointer">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-6 h-6 my-1">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M6 18L18 6M6 6l12 12" />
            </svg>
          </div>
        </div>
      </div>
      <div class="p-2 w-full text-lg">
        <lable>調べた内容・メモ</lable>
        <textarea
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          placeholder="説明説明説明説明説明説明説明"
          name="description"
          v-model="design.description">
        </textarea>
      </div>
      <div class="p-2 w-full text-lg mb-8">
        <lable>タグ</lable><br />
        <input
          class="md:w-5/6 rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          type="text"
          name="title"
          placeholder="入力してください"
          v-model="tag" />
        <button
          class="font-bold mx-auto my-2 text-white bg-gray-800 border-0 py-2 px-6 rounded-full shadow-lg shadow-gray-500/30"
          @click="tagData">
          決定
        </button>
        <div class="flex justify-start">
          <div
            v-for="(tag, index) in design.tags"
            :key="index"
            class="border border-gray-300 mr-4 px-2 py-1 rounded flex justify-center items-center">
            <div class="mr-1">
              {{ tag.name }}
            </div>
            <div @click="deleteTag(index)" class="cursor-pointer">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-6 h-6 my-1">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M6 18L18 6M6 6l12 12" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <button
        class="flex mx-auto font-bold text-white bg-gray-800 border-0 py-2 px-8 rounded-full shadow-lg shadow-gray-500/30 md:px-20"
        @click="updateDesign">
        ネイルデザインを更新
      </button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Vue from 'vue'
import VueYoutube from 'vue-youtube'
Vue.use(VueYoutube)
import { Chrome } from 'vue-color'
import draggable from 'vuedraggable'
import 'color-picker-lame.png'
import 'lame.png'
export default {
  components: {
    'chrome-picker': Chrome,
    draggable
  },
  data() {
    return {
      design: {
        title: '',
        nailPart: '',
        description: '',
        images: [],
        videos: [],
        youtubeVideos: [],
        colors: [],
        parts: [],
        tags: []
      },
      youtubeVideo: {
        url: ''
      },
      color: {
        lame: '',
        pickerHexNumber: '#FF7003',
        paletteHexNumber: '',
        hexNumberHex8: ''
      },
      colorPaletteHexNumbers: [
        '#000000FF',
        '#7F7F7FFF',
        '#AAAAAAFF',
        '#DFDFDFFF',
        '#FFFFFFFF',
        '#B12323FF',
        '#D52B2BFF',
        '#E27272FF',
        '#F1B8B8FF',
        '#F8DCDCFF',
        '#AA5500FF',
        '#FF8000FF',
        '#FFAA55FF',
        '#FFD5AAFF',
        '#FFEAD5FF',
        '#808000FF',
        '#D5D500FF',
        '#FFFF80FF',
        '#FFFFAAFF',
        '#FFFFD5FF',
        '#1D8D8DFF',
        '#23B1B1FF',
        '#95EAEAFF',
        '#B8F1F1FF',
        '#DCF8F8FF',
        '#15156AFF',
        '#2B2BD5FF',
        '#7272E2FF',
        '#B8B8F1FF',
        '#DCDCF8FF',
        '#8D1D8DFF',
        '#B123B1FF',
        '#E272E2FF',
        '#F1B8F1FF',
        '#F8DCF8FF',
        '#800040FF',
        '#AA0055FF',
        '#FF0080FF',
        '#FF80BFFF',
        '#FFD5EAFF'
      ],
      part: {
        name: '',
        size: '',
        quantity: 0,
        hexNumber: '',
        candidateNamesList: {
          name: [
            'ラインストーン',
            'Vカットストーン',
            'スタッズ',
            '丸カン',
            'パール'
          ],
          size: ['ss3', 'ss5', 'ss9', 'ss12', 'ss16', 'ss20', 'ss26']
        }
      },
      tag: '',
      showColorPicker: true,
      showColorPalette: false,
      colorContent: false,
      partContent: false,
      partColorContent: false
    }
  },
  computed: {
    colorShowHexNumber() {
      return function (hexNumber) {
        return {
          'background-color': hexNumber
        }
      }
    },
    colorLameStyle() {
      return this.color.lame === true
    }
  },
  mounted() {
    this.getDesign()
  },
  methods: {
    getDesign() {
      const url = location.pathname.split('/')
      const id = url[url.length - 2]
      axios.get(`/api/designs/${id}.json`).then((response) => {
        ;(this.design.id = response.data.id),
          (this.design.title = response.data.title),
          (this.design.nailPart = response.data.nailPart),
          (this.design.description = response.data.description),
          (this.design.images = response.data.images.map(
            (imageData) => imageData
          )),
          (this.design.videos = response.data.videos.map(
            (videoData) => videoData
          )),
          (this.design.youtubeVideos = response.data.youtubeVideos),
          (this.design.colors = response.data.colors),
          (this.design.parts = response.data.parts),
          (this.design.tags = response.data.tags)
      })
    },
    uploadFiles(e) {
      const files = e.target.files
      if (files === 0) {
        return
      }
      for (const file of files) {
        const fileReader = new FileReader()
        fileReader.readAsDataURL(file)
        fileReader.onload = () => {
          if (fileReader.result.startsWith('data:image')) {
            this.design.images.push(fileReader.result)
          } else {
            this.design.videos.push(fileReader.result)
          }
        }
      }
    },
    deleteImage(index) {
      this.design.images.splice(index, 1)
    },
    deleteVideo(url) {
      this.design.videos.splice(url, 1)
    },
    youtubeVideoData() {
      if (this.youtubeVideo.url !== '') {
        this.design.youtubeVideos.push({
          accessCode: this.youtubeVideo.url.slice(-11)
        })
        this.youtubeVideo.url = ''
      }
    },
    deleteYoutubeVideo(index) {
      this.design.youtubeVideos.splice(index, 1)
    },
    showColorContent() {
      this.colorContent = !this.colorContent
    },
    switchToColorPicker() {
      this.showColorPicker = true
      this.showColorPalette = false
    },
    switchToColorPalette() {
      this.showColorPalette = true
      this.showColorPicker = false
    },
    colorData() {
      if (this.color.pickerHexNumber !== '') {
        this.color.hexNumberHex8 = this.color.pickerHexNumber.hex8
      }
      if (this.color.paletteHexNumber !== '') {
        this.color.hexNumberHex8 = this.color.paletteHexNumber
      }

      if (
        this.color.lame !== '' &&
        (this.color.pickerHexNumber !== '' ||
          this.color.paletteHexNumber !== '')
      ) {
        this.design.colors.push({
          lame: this.color.lame,
          hexNumber: this.color.hexNumberHex8
        })
        this.color.lame = ''
        this.color.hexNumber = '#E0E0E0'
      }
    },
    deleteColor(index) {
      this.design.colors.splice(index, 1)
    },
    partData() {
      if (this.part.name !== '' && this.part.quantity !== '') {
        this.design.parts.push({
          name: this.part.name,
          size: this.part.size,
          quantity: this.part.quantity,
          hexNumber: this.part.hexNumber
        })
        this.part.name = ''
        this.part.size = ''
        this.part.quantity = '0'
        this.part.hexNumber = ''
        this.partColorContent = false
      }
    },
    selectPartName(index) {
      this.part.name = this.part.candidateNamesList.name[index]
    },
    selectPartSize(index) {
      this.part.size = this.part.candidateNamesList.size[index]
    },
    showPartContent() {
      this.partContent = !this.partContent
    },
    showPartColorContent() {
      this.partColorContent = !this.partColorContent
    },
    deletePart(index) {
      this.design.parts.splice(index, 1)
    },
    tagData() {
      this.design.tags.push({
        name: this.tag
      })
      this.tag = ''
    },
    deleteTag(index) {
      this.design.tags.splice(index, 1)
    },
    updateDesign() {
      const formData = new FormData()

      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nailPart,
        'design[images]': this.design.images,
        'design[videos]': this.design.videos
      }
      Object.entries(params).forEach(([key, value]) => {
        if (Array.isArray(value)) {
          value.forEach((v) => {
            formData.append(key + '[]', v)
          })
        } else {
          formData.append(key, value)
        }
      })

      const youtubeVideoParams = this.design.youtubeVideos
      youtubeVideoParams.forEach((youtubeVideo) => {
        formData.append(
          'design[youtube_videos_attributes][][access_code]',
          youtubeVideo.accessCode
        )
      })

      const colorParams = this.design.colors
      colorParams.forEach((color) => {
        formData.append('design[colors_attributes][][lame]', color.lame)
        formData.append(
          'design[colors_attributes][][hex_number]',
          color.hexNumber
        )
      })

      const partParams = this.design.parts
      partParams.forEach((part) => {
        formData.append('design[parts_attributes][][name]', part.name)
        formData.append('design[parts_attributes][][size]', part.size)
        formData.append('design[parts_attributes][][quantity]', part.quantity)
        formData.append(
          'design[parts_attributes][][hex_number]',
          part.hexNumber
        )
      })

      const tagParams = this.design.tags
      tagParams.forEach((tag) => {
        formData.append('design[tags_attributes][][name]', tag.name)
      })

      axios
        .post('/api/designs', formData, {
          headers: {
            'content-type': 'multipart/form-data'
          }
        })
        .then(() => (window.location.href = '/designs'))
        .catch((e) => console.log(e))
    }
  }
}
</script>

<style scoped>
.color-picker-img {
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}
.switch-color-button {
  background: #ffffff;
  color: #4b5563;
  border: 1px solid #d1d5db;
}
.rotate-to-open {
  transform: rotate(90deg);
  transition: all 0.5s ease-in-out;
}
.external-link {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25' /%3E%3C/svg%3E%0A");
}
.checkbox:checked {
  border: none;
}
</style>
