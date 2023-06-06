<template>
  <div>
    <label :for="id" class="block text-lg">画像&nbsp;&#47;&nbsp;8枚まで</label>
    <div class="mt-1">
      <label
        class="inline-block p-2 bg-gray-100 border border-gray-300 text-gray-500 hover:opacity-70 rounded cursor-pointer">
        <input
          type="file"
          :name="name"
          :id="id"
          multiple="multiple"
          accept="image/*"
          @change="uploadImages"
          class="hidden" />
        ファイルを選択
      </label>
      <p class="mt-0.5 text-xs text-justify">
        jpeg&#47;jpg&#47;png&middot;5MG以下
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'UploadImages',
  props: {
    name: { type: String, required: true },
    id: { type: String, required: true }
  },
  methods: {
    uploadImages(e) {
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
            if (file.size <= 5000000)
              this.$emit('upload-images', fileReader.result)
          } else {
            alert('jpeg・jpg・png 以外は登録できません。')
          }
        }
      }
    }
  }
}
</script>
