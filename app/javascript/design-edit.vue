<template>
  <div class="text-gray-600 py-10 mx-auto mb-4">
    <h2 class="text-2xl text-center py-10">ネイルデザインを編集</h2>
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
          v-if="
            (design.images && design.images.length > 0) ||
            design.imageToDelete.length > 0
          "
          class="text-sm mt-6 flex gap-0.5 items-center">
          <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
          <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
          で登録する画像を選択できます。
        </div>
        <div
          v-if="design.images && design.images.length"
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
              :src="image.url"
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
                :src="image.url"
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
      <div class="p-2">
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
        v-if="design.youtubeVideos.length > 0"
        class="text-sm mt-2 mb-6 ml-2 flex gap-0.5 items-center">
        <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
        <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
        で登録する動画を選択できます。
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
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
          </div>
        </div>
      </div>
      <div v-if="deleteYoutubeVideos.length > 0">
        <div class="text-sm ml-2 my-4 md:my-8 md:text-base">
          削除するYouTube動画
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
              <img src="~plus.svg" alt="プラスアイコン" class="w-5 h-5" />
            </div>
          </div>
        </div>
      </div>
      <h3 class="p-2 text-lg">カラー・パーツ</h3>
      <external-link></external-link>
      <color-input @update-color="updateColor"></color-input>
      <div
        v-if="design.colors.length > 0"
        class="text-sm mt-4 mb-6 mx-2 flex gap-0.5 items-center">
        <img src="~plus.svg" alt="プラスアイコン" class="w-4 h-4" />
        <img src="~minus.svg" alt="マイナスアイコン" class="w-4 h-4" />
        で登録するカラーを選択できます。
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
              alt="ラメ"
              class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
          </div>
          <div v-else-if="color.lame === false"></div>
          <div
            class="ml-6 -mt-2 cursor-pointer absolute z-20"
            @click="deleteColor(color)">
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
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
                alt="ラメ"
                class="w-8 h-8 rounded-full opacity-80 absolute z-10" />
            </div>
            <div v-else-if="color.lame === false"></div>
            <div
              class="ml-6 -mt-2 cursor-pointer absolute z-20"
              @click="saveColor(color)">
              <img src="~plus.svg" alt="プラスアイコン" class="w-5 h-5" />
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
            <img src="~minus.svg" alt="マイナスアイコン" class="w-5 h-5" />
          </div>
        </div>
      </div>
      <div class="p-2">
        <lable class="text-lg">調べた内容・メモ</lable>
        <textarea
          class="w-full rounded border border-gray-300 focus:border-gray-500 focus:ring-2 focus:ring-gray-300 text-base outline-none text-gray-700 py-1 px-3 leading-8 duration-200 ease-in-out"
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
            v-for="tag in saveTags"
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
import draggable from 'vuedraggable'
import ExternalLink from './components/external-link.vue'
import ChildTextInput from './components/child-text-input.vue'
import PartInput from './components/part-input.vue'
import ColorInput from './components/color-input.vue'
import 'plus.svg'
import 'minus.svg'
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
        id: '',
        title: '',
        nailPart: 'ハンド',
        description: '',
        images: [],
        imageToDelete: [],
        youtubeVideos: [],
        colors: [],
        parts: [],
        tags: []
      },
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
        ;(this.design.id = response.data.id),
          (this.design.title = response.data.title),
          (this.design.nailPart = response.data.nailPart),
          (this.design.description = response.data.description),
          (this.design.youtubeVideos = response.data.youtubeVideos),
          (this.design.colors = response.data.colors),
          (this.design.videos = response.data.videos),
          (this.design.parts = response.data.parts),
          (this.design.tags = response.data.tags),
          (this.design.images =
            response.data.images !== null ? response.data.images : [])
      })
    },
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
            if (file.size <= 5000000) {
              this.design.images.push({
                id: '',
                url: fileReader.result,
                _destroy: '0'
              })
            }
          } else {
            alert('jpeg・jpg・png 以外は登録できません。')
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
    updateColor(lame, pickerHexNumber, paletteHexNumber, hexNumberHex8) {
      if (pickerHexNumber !== '') {
        hexNumberHex8 = pickerHexNumber.hex8
      }
      if (paletteHexNumber !== '') {
        hexNumberHex8 = paletteHexNumber
      }
      if (lame !== '' && (pickerHexNumber !== '' || paletteHexNumber !== '')) {
        this.design.colors.push({
          id: '',
          lame: lame,
          hexNumber: hexNumberHex8,
          _destroy: '0'
        })
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
    },
    deleteTag(tag) {
      this.$set(tag, '_destroy', '1')
    },
    updateDesign() {
      if (!this.design.title) {
        alert('タイトルは登録必須です。')
        return
      }
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
