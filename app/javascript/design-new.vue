<template>
  <div class="text-gray-600 py-10 mx-auto mb-4">
    <h2 class="text-2xl text-center py-10">ネイルデザインを登録</h2>
    <div class="w-11/12 mx-auto">
      <div class="p-2">
        <lable class="text-lg">タイトル&#65288;入力必須&#65289;</lable>
        <input
          class="form-field"
          type="text"
          name="design[title]"
          id="design-title"
          placeholder="入力してください"
          v-model="design.title" />
      </div>
      <div class="p-2 w-full text-lg">
        <label
          >ハンド&nbsp;
          <input
            class="w-4 h-4"
            type="radio"
            name="design[nail_part]"
            value="ハンド"
            id="hand"
            v-model="design.nailPart" /> </label
        >&emsp;
        <label
          >フット&nbsp;
          <input
            class="w-4 h-4"
            type="radio"
            name="design[nail_part]"
            value="フット"
            id="foot"
            v-model="design.nailPart" />
        </label>
      </div>
      <div class="p-2 w-full text-lg">
        <lable class="block mb-2">
          画像&#65288;8枚まで&#65289;<br class="sm:hidden" />
          <span class="text-sm">jpeg&#47;jpg&#47;png&middot;5MG以下</span>
        </lable>
        <input
          type="file"
          name="design[images]"
          id="design-image"
          multiple="multiple"
          accept="image/*"
          @change="uploadFiles"
          class="text-sm w-64 md:text-lg md:w-full" />
        <div
          v-if="design.images.length > 0 || design.imageToDelete.length > 0"
          class="text-sm mt-6 flex gap-0.5 items-center">
          <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
          <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
          で登録する画像を選択できます。
        </div>
        <div
          v-if="design.images.length > 0"
          class="text-sm mb-8 mt-1 leading-6">
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
          ><br />
        </div>
        <draggable
          v-model="design.images"
          draggable=".item"
          class="files grid grid-cols-3 md:grid-cols-4 gap-3">
          <div
            class="item relative mb-4 md:mb-8"
            v-for="image in design.images"
            :key="image">
            <img
              :src="image"
              alt="登録画像"
              class="z-0 aspect-[4/3] w-full object-cover" />
            <div
              @click="deleteImage(image)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
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
                :src="image"
                alt="削除画像"
                class="z-0 aspect-[4/3] w-full object-cover opacity-60" />
              <div
                @click="saveImage(image)"
                class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
                <img src="~plus.svg" alt="プラスアイコン" class="w-5 h-5" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="p-2 youtube-input">
        <child-text-input
          placeholder="youtubeのURL"
          name="design[youtube_videos_attributes][][access_code]"
          id="design-youtube"
          @update-value="updateYoutubeVideo">
          <template v-slot:label>
            YouTube動画<br />
            <span class="text-sm"
              >URLは動画内の共有&rarr;コピーで取得出来ます。</span
            >
          </template>
        </child-text-input>
      </div>
      <div
        v-if="
          design.youtubeVideos.length > 0 ||
          design.youtubeVideoToDelete.length > 0
        "
        class="text-sm mt-2 mb-6 ml-2 flex gap-0.5 items-center">
        <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
        <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
        で登録する動画を選択できます。
      </div>
      <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-4 mx-2">
        <div
          v-for="youtubeVideo in design.youtubeVideos"
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
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
          </div>
        </div>
      </div>
      <div v-if="design.youtubeVideoToDelete.length > 0">
        <div class="text-sm ml-2 my-4 md:my-8 md:text-base">
          削除するyoutube動画
        </div>
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-4 mx-2">
          <div
            v-for="youtubeVideo in design.youtubeVideoToDelete"
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
              <img src="~plus.svg" alt="プラスアイコン" class="w-5 h-5" />
            </div>
          </div>
        </div>
      </div>
      <div class="p-2 text-lg">カラー・パーツ</div>
      <external-link></external-link>
      <color-input @update-color="updateColor"></color-input>
      <div
        v-if="design.colors.length > 0 || design.colorToDelete.length > 0"
        class="text-sm mt-4 mb-6 mx-2 flex gap-0.5 items-center">
        <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
        <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
        で登録するカラーを選択できます。
      </div>
      <div class="grid grid-cols-5 mb-2 mx-2 sm:grid-cols-10">
        <div
          v-for="color in design.colors"
          :key="color"
          :style="colorShowHexNumber(color.hexNumber)"
          class="w-8 h-8 rounded-full shadow-md mb-4">
          <div v-if="color.lame" class="relative">
            <img
              src="~lame.png"
              alt="ラメ"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="!color.lame"></div>
          <div
            @click="deleteColor(color)"
            class="ml-6 -mt-2 cursor-pointer absolute z-20">
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
          </div>
        </div>
      </div>
      <div v-if="design.colorToDelete.length > 0">
        <div class="text-sm mx-2 my-4 md:my-8 md:text-base">削除するカラー</div>
        <div class="grid grid-cols-5 mb-2 mx-2 sm:grid-cols-10">
          <div
            v-for="color in design.colorToDelete"
            :key="color"
            :style="colorShowHexNumber(color.hexNumber)"
            class="w-8 h-8 rounded-full shadow-md mb-4">
            <div v-if="color.lame" class="relative">
              <img
                src="~lame.png"
                alt="ラメ"
                class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
            </div>
            <div v-else-if="!color.lame"></div>
            <div
              class="ml-6 -mt-2 cursor-pointer absolute z-20"
              @click="saveColor(color)">
              <img src="~plus.svg" alt="プラスアイコン" class="w-5 h-5" />
            </div>
          </div>
        </div>
      </div>
      <part-input @update-part="updatePart"></part-input>
      <div v-for="part in design.parts" :key="part" class="mb-4 mx-2">
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
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
          </div>
        </div>
      </div>
      <div class="p-2">
        <lable class="text-lg">調べた内容・メモ</lable>
        <textarea
          class="form-field"
          placeholder="入力してください"
          name="design[description]"
          id="design-description"
          v-model="design.description">
        </textarea>
      </div>
      <div class="p-2 mb-8 tags-input">
        <child-text-input
          placeholder="入力してください"
          name="design[tags_attributes][][name]"
          id="design-tag"
          @update-value="updateTag">
          <template v-slot:label>
            タグ<br />
            <span class="text-sm">重複登録した分のタグは保存されません。</span>
          </template>
        </child-text-input>
        <div class="flex flex-wrap mt-2">
          <div
            v-for="tag in design.tags"
            :key="tag"
            class="mr-4 py-1 rounded flex justify-start items-center">
            <div class="mr-2 font-semibold">
              {{ tag.name }}
            </div>
            <div @click="deleteTag(tag)" class="cursor-pointer">
              <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
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
import Vue from 'vue'
import VueYoutube from 'vue-youtube'
Vue.use(VueYoutube)
import draggable from 'vuedraggable'
import 'color-picker-lame.png'
import 'lame.png'
import ExternalLink from './components/external-link.vue'
import ChildTextInput from './components/child-text-input.vue'
import PartInput from './components/part-input.vue'
import ColorInput from './components/color-input.vue'
export default {
  components: {
    draggable,
    ExternalLink,
    ChildTextInput,
    PartInput,
    ColorInput
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
    colorShowHexNumber() {
      return function (hexNumber) {
        return {
          'background-color': hexNumber
        }
      }
    }
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
