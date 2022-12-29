<template>
  <div class="text-gray-600 py-10 mx-auto mb-4">
    <h2 class="text-2xl text-center py-10">ネイルデザインを編集</h2>
    <div class="w-11/12 mx-auto">
      <div class="p-2">
        <lable class="text-lg">タイトル</lable>
        <input
          class="form-field"
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
          value="ハンド"
          v-model="design.nailPart" />&emsp; <label>フット</label>&nbsp;
        <input
          class="w-4 h-4"
          type="radio"
          name="nail_part"
          value="フット"
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
        <div
          v-if="
            (design.images && design.images.length > 0) ||
            design.imageToDelete.length > 0
          "
          class="text-sm mt-6">
          &plus;&minus;ボタンで登録したい画像を選択できます。
        </div>
        <div v-if="design.images && design.images.length" class="text-sm mb-8">
          複数枚登録する場合はドラッグ&amp;ドロップで並び替え可能です。
        </div>
        <draggable
          v-model="design.images"
          draggable=".item"
          class="grid grid-cols-3 md:grid-cols-4 gap-3">
          <div
            class="item relative mb-4 md:mb-8"
            v-for="image in design.images"
            :key="image">
            <img
              :src="image.url"
              class="z-0 aspect-[4/3] w-full object-cover" />
            <div
              @click="deleteImage(image)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5 stroke-white rounded-md bg-gray-800">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M18 12H6" />
              </svg>
            </div>
          </div>
        </draggable>
        <div v-if="design.imageToDelete.length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">削除する画像</div>
          <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
            <div
              class="relative mb-4 md:mb-8"
              v-for="image in design.imageToDelete"
              :key="image">
              <img
                :src="image.url"
                class="z-0 aspect-[4/3] w-full object-cover opacity-60" />
              <div
                @click="saveImage(image)"
                class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-5 h-5 stroke-white rounded-md bg-gray-800 shadow-lg">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M12 6v12m6-6H6" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="p-2 text-lg">
        <lable>動画&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="video"
          multiple="multiple"
          accept="video/*"
          @change="uploadFiles"
          class="text-sm w-64 md:text-lg md:w-full" />
        <div v-if="saveVideos().length > 0" class="text-sm my-6">
          &plus;&minus;ボタンで登録したい動画を選択できます。
        </div>
        <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
          <div
            class="relative mb-4 md:mb-8"
            v-for="video in saveVideos()"
            :key="video">
            <video class="z-0 aspect-[4/3] w-full object-cover">
              <source :src="video.url" type="video/mp4" />
            </video>
            <div
              @click="deleteVideo(video)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5 stroke-white rounded-md bg-gray-800">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M18 12H6" />
              </svg>
            </div>
          </div>
        </div>
        <div v-if="deleteVideos().length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">削除する動画</div>
          <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
            <div
              class="relative mb-4 md:mb-8"
              v-for="video in deleteVideos()"
              :key="video">
              <video class="z-0 aspect-[4/3] w-full object-cover opacity-60">
                <source :src="video.url" type="video/mp4" />
              </video>
              <div
                @click="saveVideo(video)"
                class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-5 h-5 stroke-white rounded-md bg-gray-800 shadow-lg">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M12 6v12m6-6H6" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="p-2">
        <child-text-input
          placeholder="youtubeのURL"
          @update-value="updateYoutubeVideo">
          <template v-slot:label>youtube動画</template>
        </child-text-input>
      </div>
      <div
        v-if="design.youtubeVideos.length > 0"
        class="text-sm mt-2 mb-6 ml-2">
        &plus;&minus;ボタンで登録したい動画を選択できます。
      </div>
      <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-4 mx-2">
        <div
          v-for="youtubeVideo in saveYoutubeVideos"
          :key="youtubeVideo"
          class="relative">
          <div class="w-full aspect-video">
            <youtube
              :video-id="youtubeVideo.accessCode"
              class="z-0 w-full h-full">
            </youtube>
          </div>
          <div
            @click="deleteYoutubeVideo(youtubeVideo)"
            class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-5 h-5 stroke-white rounded-md bg-gray-800">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M18 12H6" />
            </svg>
          </div>
        </div>
      </div>
      <div v-if="deleteYoutubeVideos.length > 0">
        <div class="text-sm ml-2 my-4 md:my-8 md:text-base">
          削除するyoutube動画
        </div>
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-4 mx-2">
          <div
            v-for="youtubeVideo in deleteYoutubeVideos"
            :key="youtubeVideo"
            class="relative">
            <div class="w-full aspect-video">
              <youtube
                :video-id="youtubeVideo.accessCode"
                class="z-0 w-full h-full opacity-60">
              </youtube>
            </div>
            <div
              @click="saveYoutubeVideo(youtubeVideo)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5 stroke-white rounded-md bg-gray-800 shadow-lg">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M12 6v12m6-6H6" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">カラー・パーツ</h3>
      <external-link></external-link>
      <h3 class="p-2 text-lg">
        カラーイメージを登録する
        <input type="checkbox" @click="showColorContent" />
      </h3>
      <div
        class="mb-4 w-full border border-gray-300 rounded"
        v-show="colorContent">
        <div class="my-4 md:mb-8 pl-2 md:pl-4">
          <lable>ラメ</lable>&emsp; なし&nbsp;
          <input type="radio" v-model="color.lame" :value="false" />&emsp;
          あり&nbsp;
          <input type="radio" v-model="color.lame" :value="true" />
        </div>
        <div
          class="flex justify-around gap-2 md:gap-4 mb-6 md:mb-10 max-w-xl mx-2 sm:mx-auto">
          <button
            :class="!showColorPicker ? 'switch-color-button' : ''"
            @click="switchToColorPicker"
            class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
            カラーピッカー
          </button>
          <button
            :class="!showColorPalette ? 'switch-color-button' : ''"
            @click="switchToColorPalette"
            class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
            カラーパレット
          </button>
        </div>
        <div v-show="showColorPicker">
          <div class="relative h-64">
            <img
              src="~color-picker-lame.png"
              v-if="colorLameStyle"
              class="color-picker-img absolute z-10 pointer-events-none" />
            <chrome-picker
              class="absolute z-0 color-picker-img"
              :value="color.pickerHexNumber"
              v-model="color.pickerHexNumber">
            </chrome-picker>
          </div>
        </div>
        <div v-show="showColorPalette">
          <div class="relative">
            <ul class="grid gap-2 grid-cols-5 place-items-center w-48 mx-auto">
              <li
                v-for="(hexNumber, index) in colorPaletteHexNumbers"
                :key="index"
                :style="colorShowHexNumber(hexNumber)"
                class="w-8 h-8 rounded-full cursor-pointer shadow-md">
                <img
                  src="~lame.png"
                  v-if="colorLameStyle"
                  class="absolute z-10 w-8 h-8 rounded-full opacity-80 pointer-events-none" />
                <input
                  type="radio"
                  v-model="color.paletteHexNumber"
                  :value="hexNumber"
                  class="checkbox-btn" />
              </li>
            </ul>
          </div>
        </div>
        <button
          class="main-action-btn mt-4 mb-6 md:mt-6 md:mb-8"
          @click="colorData">
          決定
        </button>
      </div>
      <div v-if="design.colors.length > 0" class="text-sm my-4 mx-2">
        &plus;&minus;ボタンで登録したいカラーを選択できます。
      </div>
      <div class="grid grid-cols-5 mb-2 mx-2 sm:grid-cols-10">
        <div
          v-for="color in saveColors"
          :key="color"
          :style="colorShowHexNumber(color.hexNumber)"
          class="w-8 h-8 rounded-full shadow-md mb-4">
          <div v-if="color.lame === true" class="relative">
            <img
              src="~lame.png"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="color.lame === false"></div>
          <div
            class="ml-6 -mt-2 cursor-pointer absolute z-20"
            @click="deleteColor(color)">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-5 h-5 stroke-white rounded-md bg-gray-800">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M18 12H6" />
            </svg>
          </div>
        </div>
      </div>
      <div v-if="deleteColors.length > 0">
        <div class="text-sm mx-2 my-4 md:my-8 md:text-base">削除するカラー</div>
        <div class="grid grid-cols-5 mb-2 mx-2 sm:grid-cols-10">
          <div
            v-for="color in deleteColors"
            :key="color"
            :style="colorShowHexNumber(color.hexNumber)"
            class="w-8 h-8 rounded-full shadow-md mb-4">
            <div v-if="color.lame === true" class="relative">
              <img
                src="~lame.png"
                class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
            </div>
            <div v-else-if="color.lame === false"></div>
            <div
              class="ml-6 -mt-2 cursor-pointer absolute z-20"
              @click="saveColor(color)">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5 stroke-white rounded-md bg-gray-800 shadow-lg">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M12 6v12m6-6H6" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <part-input @update-part="updatePart"></part-input>
      <div v-for="part in saveParts" :key="part" class="mb-4 mx-2">
        <div class="flex justify-between items-center">
          <div class="flex items-center">
            <div class="mr-4">
              <span class="font-semibold md:w-48 md:inline-block">{{
                part.name
              }}</span
              ><br class="md:hidden" />
              <input
                class="text-sm md:text-base mr-1 rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 outline-none text-gray-700 md:py-2 px-4 leading-8 duration-200 ease-in-out w-16 md:w-20"
                type="text"
                name="size"
                v-model="part.size" />
              <input
                class="text-sm md:text-base rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 outline-none text-gray-700 md:py-2 pl-2 leading-8 duration-200 ease-in-out w-12 md:w-16"
                type="number"
                min="0"
                onkeypress="return (event.charCode === 8 || event.charCode === 46) ? null : event.charCode >= 48 && event.charCode <= 57"
                name="quantity"
                placeholder="0"
                v-model="part.quantity" />&nbsp;個
            </div>
            <div v-if="!part.hexNumber" class="w-8 h-8 mt-6 md:mt-0"></div>
            <div
              v-else
              :style="colorShowHexNumber(part.hexNumber)"
              class="rounded-full shadow-md w-8 h-8 mt-6 md:mt-0"></div>
          </div>
          <div @click="deletePart(part)" class="cursor-pointer mt-6 md:mt-0">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-5 h-5 stroke-white rounded-md bg-gray-800">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M18 12H6" />
            </svg>
          </div>
        </div>
      </div>
      <div class="p-2">
        <lable class="text-lg">調べた内容・メモ</lable>
        <textarea
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 text-base outline-none text-gray-700 py-1 px-3 leading-8 duration-200 ease-in-out"
          placeholder="入力してください"
          name="description"
          v-model="design.description">
        </textarea>
      </div>
      <div class="p-2 mb-8">
        <child-text-input
          placeholder="入力してください"
          @update-value="updateTag">
          <template v-slot:label>タグ</template>
        </child-text-input>
        <div class="flex flex-wrap mt-2">
          <div
            v-for="tag in saveTags"
            :key="tag"
            class="mr-4 py-1 rounded flex justify-start items-center">
            <div class="mr-2 font-semibold">
              {{ tag.name }}
            </div>
            <div @click="deleteTag(tag)" class="cursor-pointer">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5 stroke-white rounded-md bg-gray-800">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M18 12H6" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <button class="main-action-btn" @click="updateDesign">
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
import ExternalLink from './components/external-link.vue'
import ChildTextInput from './components/child-text-input.vue'
import PartInput from './components/part-input'
export default {
  components: {
    'chrome-picker': Chrome,
    draggable,
    ExternalLink,
    ChildTextInput,
    PartInput
  },
  data() {
    return {
      design: {
        id: '',
        title: '',
        nailPart: '',
        description: '',
        images: [],
        imageToDelete: [],
        videos: [],
        youtubeVideos: [],
        colors: [],
        parts: [],
        tags: []
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
      showColorPicker: true,
      showColorPalette: false,
      colorContent: false,
      value: 0,
      destroy: false
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
    },
    saveColors() {
      return this.design.colors.filter(function (color) {
        return color._destroy === '0'
      })
    },
    deleteColors() {
      return this.design.colors.filter(function (color) {
        return color._destroy === '1'
      })
    },
    saveYoutubeVideos() {
      return this.design.youtubeVideos.filter(function (youtubeVideo) {
        return youtubeVideo._destroy === '0'
      })
    },
    deleteYoutubeVideos() {
      return this.design.youtubeVideos.filter(function (youtubeVideo) {
        return youtubeVideo._destroy === '1'
      })
    },
    saveTags() {
      return this.design.tags.filter(function (tag) {
        return tag._destroy === '0'
      })
    },
    saveParts() {
      return this.design.parts.filter(function (part) {
        return part._destroy === '0'
      })
    }
  },
  mounted() {
    this.getDesign()
  },
  methods: {
    async getDesign() {
      const url = location.pathname.split('/')
      const id = url[url.length - 2]
      await axios.get(`/api/designs/${id}.json`).then((response) => {
        console.log(response.data)
        ;(this.design.id = response.data.id),
          (this.design.title = response.data.title),
          (this.design.nailPart = response.data.nailPart),
          (this.design.description = response.data.description),
          (this.design.youtubeVideos = response.data.youtubeVideos),
          (this.design.colors = response.data.colors),
          (this.design.videos = response.data.videos),
          (this.design.parts = response.data.parts),
          (this.design.tags = response.data.tags),
          (this.design.videos =
            response.data.videos !== null ? response.data.videos : []),
          (this.design.images =
            response.data.images !== null ? response.data.images : [])
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
            this.design.images.push({
              id: '',
              url: fileReader.result,
              _destroy: '0'
            })
            this.design.selectedImages.push({
              id: '',
              url: fileReader.result,
              _destroy: '0'
            })
          } else {
            this.design.videos.push({
              id: '',
              url: fileReader.result,
              _destroy: '0'
            })
          }
        }
      }
    },
    deleteImage(image) {
      this.$set(image, '_destroy', '1')
      this.design.imageToDelete.push(image)
      const index = this.design.images.indexOf(image)
      this.design.images.splice(index, 1)
    },
    saveImage(image) {
      this.$set(image, '_destroy', '0')
      this.design.images.push(image)
      const index = this.design.imageToDelete.indexOf(image)
      this.design.imageToDelete.splice(index, 1)
    },
    deleteVideo(video) {
      this.$set(video, '_destroy', '1')
    },
    saveVideo(video) {
      this.$set(video, '_destroy', '0')
    },
    saveVideos() {
      this.design.videos === undefined
        ? (this.design.videos = [])
        : this.design.videos
      return this.design.videos.filter(function (video) {
        return video._destroy === '0'
      })
    },
    deleteVideos() {
      return this.design.videos.filter(function (video) {
        return video._destroy === '1'
      })
    },
    updateYoutubeVideo(url) {
      if (url !== '') {
        this.design.youtubeVideos.push({
          id: '',
          accessCode: url.slice(-11),
          _destroy: '0'
        })
      }
    },
    deleteYoutubeVideo(youtubeVideo) {
      this.$set(youtubeVideo, '_destroy', '1')
    },
    saveYoutubeVideo(youtubeVideo) {
      this.$set(youtubeVideo, '_destroy', '0')
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
          id: '',
          lame: this.color.lame,
          hexNumber: this.color.hexNumberHex8,
          _destroy: '0'
        })
        this.color.lame = ''
        this.color.hexNumber = '#E0E0E0'
      }
    },
    deleteColor(color) {
      this.$set(color, '_destroy', '1')
    },
    saveColor(color) {
      this.$set(color, '_destroy', '0')
    },
    updatePart(name, size, quantity, hexNumber) {
      if (name !== '' && quantity !== '') {
        this.design.parts.push({
          id: '',
          name: name,
          size: size,
          quantity: quantity,
          hexNumber: hexNumber,
          _destroy: '0'
        })
      }
    },
    deletePart(part) {
      this.$set(part, '_destroy', '1')
    },
    updateTag(name) {
      this.design.tags.push({
        id: '',
        name: name,
        design_tag_id: '',
        _destroy: '0'
      })
      this.tag = ''
    },
    deleteTag(tag) {
      this.$set(tag, '_destroy', '1')
    },
    updateDesign() {
      const formData = new FormData()

      const designParams = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nailPart
      }
      Object.entries(designParams).forEach(([key, value]) => {
        formData.append(key, value)
      })

      const newImageParams = this.design.images.filter(
        (image) => image.id === ''
      )
      newImageParams.forEach((image) => {
        formData.append('design[images][]', image.url)
      })

      const deletedImageParams = this.design.imageToDelete.filter(
        (image) => image.id !== ''
      )
      deletedImageParams.forEach((image) => {
        formData.append('design[images_attachments_attributes][][id]', image.id)
        formData.append(
          'design[images_attachments_attributes][][_destroy]',
          image._destroy
        )
      })

      const videoParams = this.design.videos
      videoParams.forEach((video) => {
        if (video.id === '' && video._destroy === '0') {
          formData.append('design[videos][]', video.url)
        } else if (video.id !== '' && video._destroy === '1') {
          formData.append(
            'design[videos_attachments_attributes][][id]',
            video.id
          )
          formData.append(
            'design[videos_attachments_attributes][][_destroy]',
            video._destroy
          )
        }
      })

      const sortImageIdParams = this.design.images
      sortImageIdParams.forEach((image) => {
        formData.append('design[sort_image_ids][]', image.id)
      })

      const youtubeVideoParams = this.design.youtubeVideos
      youtubeVideoParams.forEach((youtubeVideo) => {
        if (youtubeVideo._destroy === '0') {
          formData.append(
            'design[youtube_videos_attributes][][id]',
            youtubeVideo.id
          )
          formData.append(
            'design[youtube_videos_attributes][][access_code]',
            youtubeVideo.accessCode
          )
          formData.append(
            'design[youtube_videos_attributes][][_destroy]',
            youtubeVideo._destroy
          )
        } else if (youtubeVideo.id !== '' && youtubeVideo._destroy === '1') {
          formData.append(
            'design[youtube_videos_attributes][][id]',
            youtubeVideo.id
          )
          formData.append(
            'design[youtube_videos_attributes][][_destroy]',
            youtubeVideo._destroy
          )
        }
      })

      const colorParams = this.design.colors
      colorParams.forEach((color) => {
        if (color._destroy === '0') {
          formData.append('design[colors_attributes][][id]', color.id)
          formData.append('design[colors_attributes][][lame]', color.lame)
          formData.append(
            'design[colors_attributes][][hex_number]',
            color.hexNumber
          )
          formData.append(
            'design[colors_attributes][][_destroy]',
            color._destroy
          )
        } else if (color.id !== '' && color._destroy === '1') {
          formData.append('design[colors_attributes][][id]', color.id)
          formData.append(
            'design[colors_attributes][][_destroy]',
            color._destroy
          )
        }
      })

      const partParams = this.design.parts
      partParams.forEach((part) => {
        if (part._destroy === '0') {
          formData.append('design[parts_attributes][][id]', part.id)
          formData.append('design[parts_attributes][][name]', part.name)
          formData.append('design[parts_attributes][][size]', part.size)
          formData.append('design[parts_attributes][][quantity]', part.quantity)
          formData.append(
            'design[parts_attributes][][hex_number]',
            part.hexNumber
          )
          formData.append('design[parts_attributes][][_destroy]', part._destroy)
        } else if (part.id !== '' && part._destroy === '1') {
          formData.append('design[parts_attributes][][id]', part.id)
          formData.append('design[parts_attributes][][_destroy]', part._destroy)
        }
      })

      const tagParams = this.design.tags
      tagParams.forEach((tag) => {
        if (tag._destroy === '0') {
          formData.append('design[tags_attributes][][name]', tag.name)
        } else if (tag.id !== '' && tag._destroy === '1') {
          formData.append(
            'design[design_tags_attributes][][id]',
            tag.design_tag_id
          )
          formData.append(
            'design[design_tags_attributes][][_destroy]',
            tag._destroy
          )
        }
      })

      axios
        .patch(`/api/designs/${this.design.id}`, formData, {
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
.checkbox-btn {
  appearance: none;
  width: 40px;
  height: 40px;
  border: 2px solid #4b5563;
  border-radius: 50%;
  background: transparent;
  opacity: 0;
  margin: -11% 0 0 -12%;
}
.checkbox-btn:checked {
  opacity: 1;
}
.delete {
  opacity: 0.5;
}
</style>
