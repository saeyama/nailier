<template>
  <div>
    <h2>ネイルデザインを登録</h2>
    <div class="mx-auto">
      <div>
        <lable>タイトル</lable>
        <input type="text" name="title" placeholder="入力してください" v-model="design.title">
      </div>
      <div class="p-2 w-full text-lg">
        ハンド<input type="radio" name="nail_part" value="hand" v-model="design.nail_part">
        フット<input type="radio" name="nail_part" value="foot" v-model="design.nail_part">
      </div>
      <lable>調べた内容・メモ</lable><br>
      <textarea placeholder="説明説明説明説明説明説明説明" name="description" v-model="design.description">
      </textarea><br>
      <button @click="createDesign">ネイルデザインを登録</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      design: {
        title: '',
        description: '',
        nail_part: ''
      }
    }
  },
  methods: {
    createDesign() {
      const params = {
        'design[title]': this.design.title,
        'design[description]': this.design.description,
        'design[nail_part]': this.design.nail_part
      }

      const formData = new FormData()

      Object.entries(params).forEach(([key, value]) => {
        formData.append(key, value)
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
