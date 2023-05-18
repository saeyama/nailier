<template>
  <div class="text-gray-600 py-10 mx-auto mb-4">
    <h1 class="text-2xl text-center py-10">ネイルデザインを登録</h1>
    <div class="w-11/12 mx-auto grid gap-y-12">
      <div>
        <div
          class="flex justify-center items-center w-1/2 sm:w-1/4 mx-auto border border-gray-200 rounded">
          <label class="block flex-1 cursor-pointer">
            <input
              type="radio"
              class="peer sr-only"
              name="design[nail_part]"
              value="ハンド"
              v-model="design.nailPart" />
            <span
              class="nailpart-hand block text-center rounded-l p-2 transition peer-checked:bg-gray-800 peer-checked:text-white">
              ハンド
            </span>
          </label>
          <label class="block flex-1 cursor-pointer">
            <input
              type="radio"
              class="peer sr-only"
              name="design[nail_part]"
              value="フット"
              v-model="design.nailPart" />
            <span
              class="nailpart-foot block text-center rounded-r p-2 transition peer-checked:bg-gray-800 peer-checked:text-white">
              フット
            </span>
          </label>
        </div>
        <p class="text-xs text-center my-2">
          ネイルパート：{{ design.nailPart }}
        </p>
      </div>
      <div>
        <label
          for="design-title"
          class="block rerative text-lg after:absolute after:content-['必須'] after:text-white after:text-xs after:bg-orange-500 after:py-1.5 after:px-2 after:rounded after:ml-1">
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
        <label for="design-image" class="block text-lg"
          >画像&nbsp;&#42;8枚まで</label
        >
        <div class="mt-1">
          <label
            class="inline-block p-2 bg-gray-100 border border-gray-300 text-gray-500 hover:opacity-70 rounded cursor-pointer">
            <input
              type="file"
              name="design[images]"
              id="design-image"
              multiple="multiple"
              accept="image/*"
              @change="uploadFiles"
              class="hidden" />
            ファイルを選択
          </label>
          <p class="mt-0.5 text-xs text-gray-600 text-justify">
            jpeg&#47;jpg&#47;png&middot;5MG以下
          </p>
        </div>
        <div
          v-if="design.images.length > 0 || design.imageToDelete.length > 0"
          class="text-sm mt-6 flex gap-0.5 items-center">
          <XMarkIcon alt="削除アイコン" class="w-4 h-4 select-icon" />
          <ArrowUturnUpIcon
            alt="削除取消アイコン"
            class="w-4 h-4 select-icon" />
          で登録する画像を選択できます。
        </div>
        <div v-if="design.images.length > 0">
          <div class="text-sm mb-8 mt-1 leading-6">
            <span class="underline decoration-dotted underline-offset-2"
              >ドラッグ&amp;ドロップで並び替え可能です。</span
            ><br />
            <span class="inline-block mt-2"
              >アップロード数は現在&nbsp;<span class="text-xl">{{
                design.images.length
              }}</span
              >&nbsp;枚です。</span
            ><br />
            <span class="underline underline-offset-2"
              >8枚を超えた画像は登録されません。</span
            >
          </div>
          <draggable
            v-model="design.images"
            draggable=".item"
            class="files grid grid-cols-3 md:grid-cols-4 gap-3">
            <template #item="{ element }">
              <div
                @click="deleteImage(element)"
                class="item relative mb-4 md:mb-8 cursor-pointer"
                :key="element">
                <img
                  :src="element"
                  alt="登録画像"
                  class="aspect-[4/3] w-full object-cover" />
                <XMarkIcon
                  alt="削除アイコン"
                  class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
              </div>
            </template>
          </draggable>
        </div>
        <div v-if="design.imageToDelete.length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">削除する画像</div>
          <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
            <div
              @click="saveImage(image)"
              class="relative mb-4 md:mb-8 cursor-pointer"
              v-for="image in design.imageToDelete"
              :key="image">
              <img
                :src="image"
                alt="削除画像"
                class="aspect-[4/3] w-full object-cover opacity-60" />
              <ArrowUturnUpIcon
                alt="削除取消アイコン"
                class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
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
          v-if="
            design.youtubeVideos.length > 0 ||
            design.youtubeVideoToDelete.length > 0
          "
          class="text-sm my-6 flex gap-0.5 items-center">
          <XMarkIcon alt="削除アイコン" class="w-4 h-4 select-icon" />
          <ArrowUturnUpIcon
            alt="削除取消アイコン"
            class="w-4 h-4 select-icon" />
          で登録する動画を選択できます。
        </div>
        <div
          v-if="design.youtubeVideos.length > 0"
          class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-4">
          <div
            v-for="youtubeVideo in design.youtubeVideos"
            :key="youtubeVideo"
            class="relative">
            <div
              @click="deleteYoutubeVideo(youtubeVideo)"
              class="cursor-pointer">
              <div class="w-full aspect-video pointer-events-none">
                <YoutubeVue3
                  :videoid="youtubeVideo.accessCode"
                  :autoplay="0"
                  class="w-full h-full">
                </YoutubeVue3>
              </div>
              <XMarkIcon
                alt="削除取消アイコン"
                class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
            </div>
          </div>
        </div>
        <div v-if="design.youtubeVideoToDelete.length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">
            削除するyoutube動画
          </div>
          <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
            <div
              v-for="youtubeVideo in design.youtubeVideoToDelete"
              :key="youtubeVideo"
              class="relative">
              <div
                @click="saveYoutubeVideo(youtubeVideo)"
                class="cursor-pointer">
                <div class="w-full aspect-video pointer-events-none">
                  <YoutubeVue3
                    :videoid="youtubeVideo.accessCode"
                    :autoplay="0"
                    class="w-full h-full opacity-60">
                  </YoutubeVue3>
                </div>
                <ArrowUturnUpIcon
                  alt="削除取消アイコン"
                  class="absolute right-0 top-0 -mt-2.5 -mr-2.5 select-icon" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <external-link></external-link>
      </div>
      <div>
        <color-input @update-color="updateColor"></color-input>
        <div
          v-if="design.colors.length > 0 || design.colorToDelete.length > 0"
          class="text-sm my-6 flex gap-0.5 items-center">
          <XMarkIcon alt="削除アイコン" class="w-4 h-4 select-icon" />
          <ArrowUturnUpIcon
            alt="削除取消アイコン"
            class="w-4 h-4 select-icon" />
          で登録するカラーを選択できます。
        </div>
        <div
          v-if="design.colors.length > 0"
          class="grid grid-cols-5 mb-2 sm:grid-cols-10">
          <div
            v-for="color in design.colors"
            :key="color"
            :style="colorShowHexNumber(color.hexNumber)"
            class="w-8 h-8 rounded-full shadow-md mb-4">
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
              <XMarkIcon
                alt="削除アイコン"
                class="ml-6 -mt-2 absolute z-20 select-icon" />
            </div>
          </div>
        </div>
        <div v-if="design.colorToDelete.length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">削除するカラー</div>
          <div class="grid grid-cols-5 sm:grid-cols-10">
            <div
              v-for="color in design.colorToDelete"
              :key="color"
              :style="colorShowHexNumber(color.hexNumber)"
              class="w-8 h-8 rounded-full shadow-md mb-4">
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
                  alt="削除取消アイコン"
                  class="ml-6 -mt-2 absolute select-icon cursor-pointer" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <part-input @update-part="updatePart"></part-input>
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
              alt="削除アイコン"
              class="select-icon cursor-pointer" />
          </div>
        </div>
      </div>
      <div>
        <label for="design-description" class="text-lg">調べた内容・メモ</label>
        <textarea
          class="form-field"
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
              <XMarkIcon
                alt="削除アイコン"
                class="select-icon cursor-pointer" />
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
import ExternalLink from './components/external-link.vue'
import ChildTextInput from './components/child-text-input.vue'
import PartInput from './components/part-input.vue'
import ColorInput from './components/color-input.vue'
import { XMarkIcon } from '@heroicons/vue/24/outline'
import { ArrowUturnUpIcon } from '@heroicons/vue/24/outline'
import 'lame.png'
export default {
  components: {
    draggable,
    YoutubeVue3,
    ExternalLink,
    ChildTextInput,
    PartInput,
    ColorInput,
    XMarkIcon,
    ArrowUturnUpIcon
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
      }
    }
  },
  computed: {
    colorShowHexNumber: () => (hexNumber) => ({
      'background-color': hexNumber
    })
  },
  methods: {
    uploadFiles(e) {
      const files = e.target.files
      if (files === 0) return
      for (const file of files) {
        const fileReader = new FileReader()
        fileReader.readAsDataURL(file)
        fileReader.onload = () => {
          if (
            fileReader.result.startsWith('data:image/jpeg') ||
            fileReader.result.startsWith('data:image/jpg') ||
            fileReader.result.startsWith('data:image/png')
          ) {
            if (file.size > 5000000)
              alert('5MGを超えた画像はアップロードできません。')
            if (file.size <= 5000000) this.design.images.push(fileReader.result)
          } else {
            alert('jpeg・jpg・png 以外は登録できません。')
          }
        }
      }
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

<style scoped>
/* input[type="radio"]:checked + label {
background: #31A9EE;
color: #ffffff;
} */
</style>
