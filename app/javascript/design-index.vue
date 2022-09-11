<template>
  <div class="container text-gray-600 py-10 mx-auto">
    <h1 class="text-2xl font-bold text-center py-10">ネイルデザインリスト</h1>
    <div class="md:grid md:grid-cols-3 xl:mx-32">
      <div
        class="m-4 p-2 shadow-xl md:max-w-md"
        v-for="design in designs"
        :key="design.id">
        <div class="flex justify-between content-center m-2">
          <h2 class="text-lg font-bold">{{ design.title }}</h2>
          <div class="underline underline-offset-2">ネイルデザインを複製</div>
        </div>
        <div class="flex justify-center content-center md:block">
          <div class="w-1/2 md:w-full">
            <img
              class="w-5/6 drop-shadow-lg flex mx-auto md:w-3/4"
              :src="design.images" />
          </div>
          <div
            class="w-1/2 justify-between content-center md:flex md:justify-between md:w-full md:mb-2">
            <button
              class="flex mx-auto text-base mb-8 text-gray-600 border border-gray-600 py-2 px-12 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-2 md:px-6 md:mt-4 md:mb-2">
              詳細
            </button>
            <button
              class="flex mx-auto text-base mb-8 text-gray-600 border border-gray-600 py-2 px-12 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-2 md:px-6 md:mt-4 md:mb-2">
              編集
            </button>
            <button
              class="flex mx-auto text-base mb-8 text-gray-600 border border-gray-600 py-2 px-12 focus:outline-none hover:bg-gray-600 hover:text-white rounded-full md:py-2 md:px-6 md:mt-4 md:mb-2">
              削除
            </button>
          </div>
        </div>
        <div>
          {{ design.created_at }}&ensp;登録<br />
          {{ design.updated_at }}&ensp;更新
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      designs: []
    }
  },
  mounted() {
    this.getDesigns()
  },
  methods: {
    getDesigns() {
      axios
        .get(`/api/designs`)
        .then((response) => (this.designs = response.data.designs))
    }
  }
}
</script>

<style></style>
