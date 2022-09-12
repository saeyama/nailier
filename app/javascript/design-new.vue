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
      <div class="p-2 w-full text-lg">
        <h3>カラーイメージを登録する</h3>
        <chrome-picker class="mx-auto" :value="hex_number"></chrome-picker>
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
        class="flex font-bold mx-auto text-white bg-gray-500 border-0 py-2 px-8 rounded-full shadow-lg shadow-gray-500/30"
        @click="createDesign">
        ネイルデザインを登録
      </button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { Chrome } from 'vue-color'
export default {
  components: {
    'chrome-picker': Chrome
  },
  data() {
    return {
      design: {
        title: '',
        description: '',
        nail_part: '',
        images: [],
        urls: []
      },
      hex_number: '#194d33'
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
    createDesign() {
      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nail_part,
        'design[images]': this.design.images
      }

      const formData = new FormData()

      Object.entries(params).forEach(([key, value]) => {
        if (Array.isArray(value)) {
          value.forEach((v) => {
            formData.append(key + '[]', v)
          })
        } else {
          formData.append(key, value)
        }
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

<style></style>
