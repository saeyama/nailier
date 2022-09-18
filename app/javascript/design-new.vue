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
          @change="uploadFile" /><br />
        <div class="grid grid-cols-4 mb-4">
          <div class="full" v-for="(url, index) in design.urls" :key="index">
            <img :src="url" />
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">
        カラーイメージを登録する
        <input type="checkbox" @change="showColorContent" />
      </h3>
      <div v-show="colorContent">
        <div class="p-2 mb-4 w-full text-lg border border-gray-300 rounded">
          <div class="my-4 pl-2 md:pl-4">
            <lable>ラメ</lable>&emsp; なし&nbsp;
            <input type="radio" v-model="lame" :value="false" />&emsp;
            あり&nbsp;
            <input type="radio" v-model="lame" :value="true" />
          </div>
          <div class="flex justify-around mb-4 md:mx-4">
            <button
              @click="switchToChrome"
              class="text-white bg-gray-800 border-0 py-2 px-4 rounded-full shadow-lg shadow-gray-500/30 md:px-16">
              カラーピッカー
            </button>
            <button
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
                :value="hex_number"
                v-model="hex_number">
              </chrome-picker>
            </div>
            <div v-else class="h-64 mb-3">
              <chrome-picker
                class="mx-auto"
                :value="hex_number"
                v-model="hex_number">
              </chrome-picker>
            </div>
          </div>
          <swatches-picker
            :value="hex_number"
            v-model="hex_number"
            class="mx-auto"
            v-show="showSwatches"></swatches-picker>
          <button
            class="flex font-bold mx-auto my-8 text-white bg-gray-800 border-0 py-2 px-24 rounded-full shadow-lg shadow-gray-500/30 md:px-36"
            @click="colorData">
            決定
          </button>
        </div>
        <div class="flex space-x-12 mb-8">
          <div
            v-for="(color, index) in design.colors"
            :key="index"
            :style="colorShowHexNumber(color.hex_number)"
            class="w-8 h-8 rounded-full shadow-md shadow-gray-500/30">
            <div v-if="color.lame == true" class="relative">
              <img
                src="~lame.png"
                class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
              <div class="hidden absolute z-10">{{ color.hex_number }}</div>
            </div>
            <div v-else-if="color.lame == false">
              <div class="hidden">{{ color.hex_number }}</div>
            </div>
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
        urls: [],
        colors: []
      },
      lame: '',
      hex_number: '#194d33',
      showChrome: true,
      showSwatches: false,
      colorContent: false
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
      return this.lame === true
    }
  },
  methods: {
    uploadFile(e) {
      const image = e.target.files[0]
      const reader = new FileReader()
      this.design.urls.push(URL.createObjectURL(image))
      reader.readAsDataURL(image)
      reader.onload = () => {
        this.design.images.push(reader.result)
      }
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
      if (this.lame !== '' && this.hex_number !== '') {
        this.design.colors.push({
          lame: this.lame,
          hex_number: this.hex_number.hex8
        })
        this.lame = ''
        this.hex_number = '#194d33'
      }
    },
    deleteColor(index) {
      this.design.colors.splice(index, 1)
    },
    createDesign() {
      const formData = new FormData()

      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nail_part,
        'design[images]': this.design.images
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

      const colorParams = this.design.colors
      colorParams.forEach((color) => {
        formData.append('design[colors_attributes][][lame]', color.lame)
        formData.append(
          'design[colors_attributes][][hex_number]',
          color.hex_number
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
</style>
