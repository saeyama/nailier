<template>
  <div class="text-gray-600 py-10 mx-auto mb-4">
    <h2 class="text-2xl text-center py-10">ネイルデザインを登録</h2>
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
          v-if="design.images.length > 0 || design.imageToDelete.length > 0"
          class="text-sm mt-6">
          &plus;&minus;ボタンで登録したい画像を選択できます。
        </div>
        <div v-if="design.images.length > 0" class="text-sm mb-8">
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
            <img :src="image" class="z-0 aspect-[4/3] w-full object-cover" />
            <div
              @click="deleteImage(image)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <img src="~minus.svg" class="w-5 h-5" />
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
                class="z-0 aspect-[4/3] w-full object-cover opacity-60" />
              <div
                @click="saveImage(image)"
                class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
                <img src="~plus.svg" class="w-5 h-5" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="p-2">
        <lable>動画&#40;複数登録可&#41;</lable><br />
        <input
          type="file"
          name="video"
          multiple="multiple"
          accept="video/*"
          @change="uploadFiles"
          class="text-sm w-64 md:text-lg md:w-full" />
        <div
          v-if="design.videos.length > 0 || design.videoToDelete.length > 0"
          class="text-sm my-6">
          &plus;&minus;ボタンで登録したい画像を選択できます。
        </div>
        <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
          <div
            class="relative mb-4 md:mb-8"
            v-for="video in design.videos"
            :key="video">
            <video class="z-0 aspect-[4/3] w-full object-cover">
              <source :src="video" type="video/mp4" />
            </video>
            <div
              @click="deleteVideo(video)"
              class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
              <img src="~minus.svg" class="w-5 h-5" />
            </div>
          </div>
        </div>
        <div v-if="design.videoToDelete.length > 0">
          <div class="text-sm my-4 md:my-8 md:text-base">削除する動画</div>
          <div class="grid grid-cols-3 md:grid-cols-4 gap-3">
            <div
              class="mb-4 relative md:mb-8"
              v-for="video in design.videoToDelete"
              :key="video">
              <video class="z-0 aspect-[4/3] w-full object-cover opacity-60">
                <source :src="video" type="video/mp4" />
              </video>
              <div
                @click="saveVideo(video)"
                class="cursor-pointer absolute z-10 right-0 top-0 -mt-2.5 -mr-2.5">
                <img src="~plus.svg" class="w-5 h-5" />
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
        v-if="
          design.youtubeVideos.length > 0 ||
          design.youtubeVideoToDelete.length > 0
        "
        class="text-sm mt-2 mb-6 ml-2">
        &plus;&minus;ボタンで登録したい画像を選択できます。
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
            <img src="~minus.svg" class="w-5 h-5" />
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
              <img src="~plus.svg" class="w-5 h-5" />
            </div>
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">カラー・パーツ</h3>
      <external-link></external-link>
      <color-input @update-color="updateColor"></color-input>
      <div
        v-if="design.colors.length > 0 || design.colorToDelete.length > 0"
        class="text-sm my-4 mx-2">
        &plus;&minus;ボタンで登録したいカラーを選択できます。
      </div>
      <div class="grid grid-cols-5 mb-2 mx-2 sm:grid-cols-10">
        <div
          v-for="color in design.colors"
          :key="color"
          :style="colorShowHexNumber(color.hexNumber)"
          class="w-8 h-8 rounded-full shadow-md mb-4">
          <div v-if="color.lame == true" class="relative">
            <img
              src="~lame.png"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="color.lame == false"></div>
          <div
            @click="deleteColor(color)"
            class="ml-6 -mt-2 cursor-pointer absolute z-20">
            <img src="~minus.svg" class="w-5 h-5" />
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
            <div v-if="color.lame === true" class="relative">
              <img
                src="~lame.png"
                class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
            </div>
            <div v-else-if="color.lame === false"></div>
            <div
              class="ml-6 -mt-2 cursor-pointer absolute z-20"
              @click="saveColor(color)">
              <img src="~plus.svg" class="w-5 h-5" />
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
            <img src="~minus.svg" class="w-5 h-5" />
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
            v-for="tag in design.tags"
            :key="tag"
            class="mr-4 py-1 rounded flex justify-start items-center">
            <div class="mr-2 font-semibold">
              {{ tag.name }}
            </div>
            <div @click="deleteTag(tag)" class="cursor-pointer">
              <img src="~minus.svg" class="w-5 h-5" />
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
import axios from 'axios'
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
        nailPart: '',
        images: [],
        imageToDelete: [],
        videos: [],
        videoToDelete: [],
        youtubeVideos: [],
        youtubeVideoToDelete: [],
        colors: [],
        colorToDelete: [],
        parts: [],
        tags: []
      },
      color: {
        lame: '',
        pickerHexNumber: '#FF7003',
        paletteHexNumber: '',
        hexNumberHex8: ''
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
    },
    colorLameStyle() {
      return this.color.lame === true
    }
  },
  methods: {
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
    deleteVideo(video) {
      this.design.videoToDelete.push(video)
      const index = this.design.videos.indexOf(video)
      this.design.videos.splice(index, 1)
    },
    saveVideo(video) {
      this.design.videos.push(video)
      const index = this.design.videoToDelete.indexOf(video)
      this.design.videoToDelete.splice(index, 1)
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
