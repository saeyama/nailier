<template>
  <div>
    <h1 class="page-content-title">ネイルデザインを登録</h1>
    <div class="mb-8">
      <nailpart-radio-btn
        :options="nailParts"
        name="design[nail_part]"
        v-model="design.nailPart" />
    </div>
    <div class="grid gap-y-12">
      <div>
        <label for="design-title" class="text-lg required-icon">
          タイトル
        </label>
        <input
          class="form-field mt-1"
          type="text"
          name="design[title]"
          id="design-title"
          placeholder="デザイン名・&#x25CB;&#x25CB;検定など"
          v-model="design.title" />
      </div>
      <div>
        <upload-images
          name="design[images]"
          id="design-images"
          @upload-images="uploadImages" />
        <div
          v-if="design.images.length > 0 || design.imageToDelete.length > 0"
          class="my-6 text-sm">
          <div class="flex justify-start items-center gap-1">
            <ExclamationTriangleIcon class="w-6 h-6" />
            8枚を超えた画像は登録されません。
          </div>
          <div class="flex justify-start items-center gap-1">
            <InformationCircleIcon class="w-6 h-6" />
            ドラッグ&amp;ドロップで並び替え可能です。
          </div>
        </div>
        <draggable
          v-if="design.images.length > 0"
          v-model="design.images"
          draggable=".item"
          :handle="'.handle'"
          class="files grid grid-cols-3 md:grid-cols-4 gap-x-3 gap-y-4">
          <template #item="{ element }">
            <div class="item" :key="element">
              <div class="relative pt-[75%] cursor-pointer">
                <img
                  :src="element"
                  alt="登録画像"
                  class="handle absolute top-0 w-full h-full object-cover shadow-md" />
                <XMarkIcon
                  @click="deleteImage(element)"
                  class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
              </div>
            </div>
          </template>
        </draggable>
        <div v-if="design.imageToDelete.length > 0">
          <hr class="mt-8 mb-3" />
          <div class="text-sm flex justify-start items-center gap-1 mb-6">
            <ExclamationTriangleIcon class="w-6 h-6" />
            以下の画像は保存されません。
          </div>
          <div class="grid grid-cols-3 md:grid-cols-4 gap-x-3 gap-y-4">
            <div v-for="image in design.imageToDelete" :key="image">
              <div
                @click="saveImage(image)"
                class="relative pt-[75%] cursor-pointer">
                <img
                  :src="image"
                  alt="削除画像"
                  class="absolute top-0 w-full h-full object-cover opacity-60 shadow-md" />
                <ArrowUturnUpIcon
                  class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <child-text-input
          class="youtube-input"
          placeholder="https://youtu.be/•••"
          name="design[youtube_videos_attributes][][access_code]"
          for="design-youtube"
          id="design-youtube"
          @update-value="updateYoutubeVideo">
          <template v-slot:label> YouTube動画 </template>
          <template v-slot:description>
            URLは動画内の共有&rarr;コピーより取得
          </template>
        </child-text-input>
        <div
          v-if="design.youtubeVideos.length > 0"
          class="grid grid-cols-2 md:grid-cols-3 gap-x-3 gap-y-4 mt-6">
          <div v-for="youtubeVideo in design.youtubeVideos" :key="youtubeVideo">
            <div
              @click="deleteYoutubeVideo(youtubeVideo)"
              class="relative pt-[56.25%] cursor-pointer">
              <YoutubeVue3
                :videoid="youtubeVideo.accessCode"
                :autoplay="0"
                class="absolute top-0 w-full h-full shadow-md pointer-events-none">
              </YoutubeVue3>
              <XMarkIcon
                class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
            </div>
          </div>
        </div>
        <div v-if="design.youtubeVideoToDelete.length > 0">
          <div class="text-sm flex justify-start items-center gap-1 my-6">
            <ExclamationTriangleIcon class="w-6 h-6" />
            以下のYouTube動画は保存されません。
          </div>
          <div class="grid grid-cols-2 md:grid-cols-3 gap-x-3 gap-y-4">
            <div
              v-for="youtubeVideo in design.youtubeVideoToDelete"
              :key="youtubeVideo">
              <div
                @click="saveYoutubeVideo(youtubeVideo)"
                class="relative pt-[56.25%] cursor-pointer">
                <YoutubeVue3
                  :videoid="youtubeVideo.accessCode"
                  :autoplay="0"
                  class="absolute top-0 w-full h-full opacity-60 shadow-md pointer-events-none">
                </YoutubeVue3>
                <ArrowUturnUpIcon
                  class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <external-links />
      </div>
      <div>
        <input-color @update-color="updateColor" />
        <div
          v-if="design.colors.length > 0"
          class="grid grid-cols-5 sm:grid-cols-10 gap-y-5 mt-6">
          <div
            v-for="color in design.colors"
            :key="color"
            :style="colorShowHexNumber(color.hexNumber)"
            class="w-8 h-8 rounded-full shadow-md">
            <div @click="deleteColor(color)" class="relative cursor-pointer">
              <div v-if="color.lame" class="absolute w-8 h-8">
                <div class="relative">
                  <img
                    src="~lame.png"
                    alt="ラメ"
                    class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
                </div>
              </div>
              <div v-else-if="!color.lame" class="absolute w-8 h-8"></div>
              <XMarkIcon class="ml-6 -mt-2 absolute z-20 select-icon" />
            </div>
          </div>
        </div>
        <div v-if="design.colorToDelete.length > 0">
          <div class="text-sm flex justify-start items-center gap-1 mt-6 mb-7">
            <ExclamationTriangleIcon class="w-6 h-6" />
            以下のカラーイメージは保存されません。
          </div>
          <div class="grid grid-cols-5 sm:grid-cols-10 gap-y-5">
            <div
              v-for="color in design.colorToDelete"
              :key="color"
              :style="colorShowHexNumber(color.hexNumber)"
              class="w-8 h-8 rounded-full shadow-md">
              <div @click="saveColor(color)" class="relative cursor-pointer">
                <div v-if="color.lame" class="absolute w-8 h-8">
                  <div class="relative">
                    <img
                      src="~lame.png"
                      alt="ラメ"
                      class="w-8 h-8 rounded-full opacity-80 absolute" />
                  </div>
                </div>
                <div v-else-if="!color.lame" class="absolute w-8 h-8"></div>
                <ArrowUturnUpIcon
                  class="ml-6 -mt-2 absolute select-icon cursor-pointer" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <input-part @update-part="updatePart" />
        <div v-for="part in design.parts" :key="part" class="mt-4">
          <div class="flex flex-wrap justify-between items-center sm:gap-10">
            <div class="w-full sm:flex-1">{{ part.name }}</div>
            <div>
              <input
                class="form-field mr-2 rounded w-16 md:w-20 h-10"
                type="text"
                name="size"
                v-model="part.size" />
              <input
                class="form-field mr-1 rounded w-16 md:w-20 h-10"
                type="number"
                min="0"
                onkeypress="return (event.charCode === 8 || event.charCode === 46) ? null : event.charCode >= 48 && event.charCode <= 57"
                name="quantity"
                placeholder="0"
                v-model="part.quantity" />
              個
            </div>
            <div v-if="!part.hexNumber" class="w-8 h-8"></div>
            <div
              v-else
              :style="colorShowHexNumber(part.hexNumber)"
              class="rounded-full shadow-md w-8 h-8"></div>
            <XMarkIcon
              @click="deletePart(part)"
              class="select-icon cursor-pointer" />
          </div>
        </div>
      </div>
      <div>
        <label for="design-description" class="text-lg">調べた内容・メモ</label>
        <textarea
          class="form-field mt-1"
          placeholder="手順・カラー番号・注意点など"
          name="design[description]"
          id="design-description"
          v-model="design.description">
        </textarea>
      </div>
      <div>
        <child-text-input
          class="tags-input"
          placeholder="カラー名・&#x25CB;&#x25CB;系など"
          name="design[tags_attributes][][name]"
          id="design-tag"
          @update-value="updateTag">
          <template v-slot:label> タグ </template>
          <template v-slot:description>
            重複登録した分のタグは保存されません。<br />リストからタグ検索ができます。
          </template>
        </child-text-input>
        <div class="flex flex-wrap mt-2 gap-x-6 gap-y-2">
          <div v-for="tag in design.tags" :key="tag">
            <div
              @click="deleteTag(tag)"
              class="flex justify-start items-center gap-x-1.5 cursor-pointer">
              <div>
                {{ tag.name }}
              </div>
              <XMarkIcon class="select-icon cursor-pointer" />
            </div>
          </div>
        </div>
      </div>
      <button class="main-action-btn" @click="createDesign">
        ネイルデザインを登録
      </button>
    </div>
  </div>
</template>

<script>
import apiClient from './packs/api-client.js'
import draggable from 'vuedraggable'
import { YoutubeVue3 } from 'youtube-vue3'
import ExternalLinks from './components/external-links.vue'
import ChildTextInput from './components/child-text-input.vue'
import InputPart from './components/input-part.vue'
import InputColor from './components/input-color.vue'
import NailpartRadioBtn from './components/nailpart-radio-btn.vue'
import UploadImages from './components/upload-images.vue'
import { XMarkIcon } from '@heroicons/vue/24/outline'
import { ArrowUturnUpIcon } from '@heroicons/vue/24/outline'
import { InformationCircleIcon } from '@heroicons/vue/24/outline'
import { ExclamationTriangleIcon } from '@heroicons/vue/24/outline'
import 'lame.png'
export default {
  components: {
    draggable,
    YoutubeVue3,
    ExternalLinks,
    ChildTextInput,
    InputPart,
    InputColor,
    NailpartRadioBtn,
    UploadImages,
    XMarkIcon,
    ArrowUturnUpIcon,
    InformationCircleIcon,
    ExclamationTriangleIcon
  },
  data() {
    return {
      design: {
        title: '',
        description: '',
        nailPart: 'ハンド',
        images: [],
        imageToDelete: [],
        youtubeVideos: [],
        youtubeVideoToDelete: [],
        colors: [],
        colorToDelete: [],
        parts: [],
        tags: []
      },
      nailParts: [
        { label: 'hand', value: 'ハンド' },
        { label: 'foot', value: 'フット' }
      ]
    }
  },
  computed: {
    colorShowHexNumber: () => (hexNumber) => ({
      'background-color': hexNumber
    })
  },
  methods: {
    uploadImages(images) {
      this.design.images.push(images)
    },
    deleteImage(image) {
      this.design.imageToDelete.push(image)
      const index = this.design.images.indexOf(image)
      this.design.images.splice(index, 1)
    },
    saveImage(image) {
      this.design.images.push(image)
      const index = this.design.imageToDelete.indexOf(image)
      this.design.imageToDelete.splice(index, 1)
    },
    updateYoutubeVideo(url) {
      if (url !== '') {
        this.design.youtubeVideos.push({
          accessCode: url.slice(-11)
        })
      }
    },
    deleteYoutubeVideo(youtubeVideo) {
      this.design.youtubeVideoToDelete.push(youtubeVideo)
      const index = this.design.youtubeVideos.indexOf(youtubeVideo)
      this.design.youtubeVideos.splice(index, 1)
    },
    saveYoutubeVideo(youtubeVideo) {
      this.design.youtubeVideos.push(youtubeVideo)
      const index = this.design.youtubeVideoToDelete.indexOf(youtubeVideo)
      this.design.youtubeVideoToDelete.splice(index, 1)
    },
    updateColor(lame, pickerHexNumber, paletteHexNumber, hexNumberHex8) {
      if (pickerHexNumber !== '') {
        hexNumberHex8 = pickerHexNumber.hex8
      }
      if (paletteHexNumber !== '') {
        hexNumberHex8 = paletteHexNumber
      }
      if (lame !== '' && (pickerHexNumber !== '' || paletteHexNumber !== '')) {
        this.design.colors.push({
          lame: lame,
          hexNumber: hexNumberHex8
        })
      }
    },
    deleteColor(color) {
      this.design.colorToDelete.push(color)
      const index = this.design.colors.indexOf(color)
      this.design.colors.splice(index, 1)
    },
    saveColor(color) {
      this.design.colors.push(color)
      const index = this.design.colorToDelete.indexOf(color)
      this.design.colorToDelete.splice(index, 1)
    },
    updatePart(name, size, quantity, hexNumber) {
      if (name !== '' && quantity !== '') {
        this.design.parts.push({
          name: name,
          size: size,
          quantity: quantity,
          hexNumber: hexNumber
        })
      }
    },
    deletePart(part) {
      const index = this.design.parts.indexOf(part)
      this.design.parts.splice(index, 1)
    },
    updateTag(name) {
      this.design.tags.push({
        name: name
      })
    },
    deleteTag(tag) {
      const index = this.design.tags.indexOf(tag)
      this.design.tags.splice(index, 1)
    },
    createDesign() {
      if (!this.design.title) {
        alert('タイトルは登録必須です。')
        return
      }
      const formData = new FormData()

      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nailPart,
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

      apiClient
        .post('/api/designs', formData, {})
        .then(() => (window.location.href = '/designs'))
        .catch((e) => console.log(e))
    }
  }
}
</script>
