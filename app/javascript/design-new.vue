<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h2 class="text-2xl font-bold text-center py-10">ネイルデザインを登録</h2>
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
          v-model="design.nail_part" />&emsp; <label>フット</label>&nbsp;
        <input
          class="w-4 h-4"
          type="radio"
          name="nail_part"
          value="foot"
          v-model="design.nail_part" />
      </div>
      <div class="p-2 w-full text-lg">
        <lable>画像&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="image"
          multiple="multiple"
          accept="image/*"
          @change="uploadImageFile"
          class="text-sm md:text-lg" />
        <div class="grid grid-cols-4 mb-2">
          <div
            class="w-full mt-4"
            v-for="(url, index) in design.imageUrls"
            :key="index">
            <img :src="url" />
          </div>
        </div>
      </div>
      <div class="p-2 w-full text-lg">
        <lable>動画&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="video"
          multiple="multiple"
          accept="video/*"
          @change="uploadVideoFile"
          class="text-sm md:text-lg" />
        <div class="w-4/6 grid grid-cols-2 mb-2">
          <div
            class="w-full mt-4"
            v-for="(url, index) in design.videoUrls"
            :key="index">
            <video :src="url"></video>
          </div>
        </div>
      </div>
      <div class="p-2 w-full">
        <input
          type="text"
          name="youtubeVideo"
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
              class="w-32 h-28 md:w-64 md:h-48 absolute z-1 left-2">
            </youtube>
            <div
              @click="deleteYoutubeVideo(index)"
              class="cursor-pointer absolute z-0 top-1 -right-4 md:right-4">
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
      <h3 class="p-2 text-lg">
        カラーイメージを登録する
        <input type="checkbox" @click="showColorContent" />
      </h3>
      <div
        class="mb-4 w-full text-lg border border-gray-300 rounded"
        v-show="colorContent">
        <div class="my-4 pl-2 md:pl-4">
          <lable>ラメ</lable>&emsp; なし&nbsp;
          <input type="radio" v-model="color.lame" :value="false" />&emsp;
          あり&nbsp;
          <input type="radio" v-model="color.lame" :value="true" />
        </div>
        <div class="flex justify-around mb-4 md:mx-4 lg:mx-20">
          <button
            :class="!showChrome ? 'switch-color-button' : ''"
            @click="switchToChrome"
            class="text-white bg-gray-800 border-0 py-2 px-4 rounded-full shadow-lg shadow-gray-500/30 md:px-16">
            カラーピッカー
          </button>
          <button
            :class="!showSwatches ? 'switch-color-button' : ''"
            @click="switchToSwatches"
            class="text-white bg-gray-800 border-0 py-2 px-4 rounded-full shadow-lg shadow-gray-500/30 md:px-16">
            カラーパレット
          </button>
        </div>
        <div v-show="showChrome">
          <div v-if="colorLameStyle" class="relative h-64">
            <img
              src="~color-picker-lame.png"
              class="color-picker-img absolute z-10 pointer-events-none" />
            <chrome-picker
              class="absolute z-0 color-picker-img"
              :value="color.hexNumber"
              v-model="color.hexNumber">
            </chrome-picker>
          </div>
          <div v-else class="h-64 mb-3">
            <chrome-picker
              class="mx-auto"
              :value="color.hexNumber"
              v-model="color.hexNumber">
            </chrome-picker>
          </div>
        </div>
        <swatches-picker
          :value="color.hexNumber"
          v-model="color.hexNumber"
          class="mx-auto"
          v-show="showSwatches"></swatches-picker>
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
        class="p-4 mb-4 w-full md:px-8 text-lg border border-gray-300 rounded"
        v-show="partContent">
        <input
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
          type="text"
          name="name"
          placeholder="パーツ名を入力してください。"
          v-model="part.name" />
        <div class="my-4">
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
        <div class="my-4">
          <button
            v-for="(candidateSize, index) in part.candidateNamesList.size"
            :key="index"
            @click="selectPartSize(index)"
            class="cursor-pointer mr-4 my-1 hover:font-bold">
            {{ candidateSize }}
          </button>
        </div>
        <div
          class="flex justify-between content-center mb-6 rounded border border-gray-300 px-4 py-2">
          <label class="mt-2">個数</label>
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
          class="flex justify-between w-full rounded border border-gray-300 px-4 py-2">
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
          <swatches-picker v-model="part.hexNumber" class="mx-auto my-8">
          </swatches-picker>
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
          class="flex mb-2 mr-4 space-x-8">
          <div class="flex w-full">
            <div class="mt-1 w-3/4">
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
      <button
        class="flex mx-auto font-bold text-white bg-gray-800 border-0 py-2 px-8 rounded-full shadow-lg shadow-gray-500/30 md:px-20"
        @click="createDesign">
        ネイルデザインを登録
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
import { Swatches } from 'vue-color'
import 'color-picker-lame.png'
import 'lame.png'
export default {
  components: {
    'chrome-picker': Chrome,
    'swatches-picker': Swatches
  },
  data() {
    return {
      design: {
        title: '',
        description: '',
        nail_part: '',
        images: [],
        imageUrls: [],
        videos: [],
        videoUrls: [],
        youtubeVideos: [],
        colors: [],
        parts: []
      },
      color: {
        lame: '',
        hexNumber: '#FF7003'
      },
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
      youtubeVideo: {
        url: ''
      },
      showChrome: true,
      showSwatches: false,
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
  methods: {
    uploadImageFile(e) {
      const image = e.target.files[0]
      const reader = new FileReader()
      this.design.imageUrls.push(URL.createObjectURL(image))
      reader.readAsDataURL(image)
      reader.onload = () => {
        this.design.images.push(reader.result)
      }
    },
    uploadVideoFile(e) {
      const video = e.target.files[0]
      const reader = new FileReader()
      this.design.videoUrls.push(URL.createObjectURL(video))
      reader.readAsDataURL(video)
      reader.onload = () => {
        this.design.videos.push(reader.result)
      }
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
    switchToChrome() {
      this.showChrome = true
      this.showSwatches = false
    },
    switchToSwatches() {
      this.showSwatches = true
      this.showChrome = false
    },
    colorData() {
      if (this.color.lame !== '' && this.color.hexNumber !== '') {
        this.design.colors.push({
          lame: this.color.lame,
          hexNumber: this.color.hexNumber.hex8
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
          hexNumber: this.part.hexNumber.hex8
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
    createDesign() {
      const formData = new FormData()

      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nail_part,
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
</style>
