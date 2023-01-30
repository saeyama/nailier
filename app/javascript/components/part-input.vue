<template>
  <div class="parts-input">
    <h3 class="p-2 text-lg mb-2">
      パーツ内容を登録する
      <input type="checkbox" id="show-part-content" @click="showPartContent" />
    </h3>
    <div
      class="p-2 md:p-4 mb-4 w-full md:px-8 border border-gray-300 rounded"
      v-show="partContent">
      <input
        class="form-field"
        type="text"
        name="design[parts_attributes][][name]"
        id="design-part-name"
        placeholder="パーツ名は登録必須です。"
        v-model="part.name" />
      <div class="my-4 px-2">
        <button
          v-for="(candidateName, index) in part.candidateNamesList.name"
          :key="index"
          @click="selectPartName(index)"
          class="cursor-pointer mr-4 my-1 hover:font-bold">
          {{ candidateName }}
        </button>
      </div>
      <input
        class="form-field"
        type="text"
        name="design[parts_attributes][][size]"
        id="design-part-size"
        placeholder="大きさを入力してください。"
        v-model="part.size" />
      <div class="my-4 px-2">
        <button
          v-for="(candidateSize, index) in part.candidateNamesList.size"
          :key="index"
          @click="selectPartSize(index)"
          class="cursor-pointer mr-4 my-1 hover:font-bold">
          {{ candidateSize }}
        </button>
      </div>
      <div
        class="flex justify-between items-center mb-6 rounded border border-gray-300 px-4 py-2">
        <label>個数</label>
        <input
          class="form-field w-20"
          type="number"
          name="design[parts_attributes][][quantity]"
          id="design-part-quantity"
          min="1"
          onkeypress="return (event.charCode === 8 || event.charCode === 46) ? null : event.charCode >= 48 && event.charCode <= 57"
          v-model="part.quantity" />
      </div>

      <div
        class="flex justify-between items-center w-full rounded border border-gray-300 px-4 py-2">
        <label>カラー</label>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="show-part-color-content w-6 h-6"
          :class="{ 'rotate-to-open': partColorContent }"
          @click="showPartColorContent">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M8.25 4.5l7.5 7.5-7.5 7.5" />
        </svg>
      </div>
      <div
        class="rounded-b-lg border border-gray-300 py-6"
        v-show="partColorContent">
        <ul
          class="part-hexnumber grid gap-2 grid-cols-5 place-items-center w-48 mx-auto">
          <li
            v-for="(hexNumber, index) in colorPaletteHexNumbers"
            :key="index"
            :style="colorShowHexNumber(hexNumber)"
            class="w-8 h-8 rounded-full cursor-pointer shadow-md">
            <input
              type="radio"
              v-model="part.hexNumber"
              :value="hexNumber"
              name="design[parts_attributes][][hex_number]"
              class="checkbox-btn" />
          </li>
        </ul>
      </div>
      <button
        class="main-action-btn mt-6 mb-4 md:mt-8 md:mb-4"
        @click="updatePart">
        決定
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PartInput',
  data() {
    return {
      part: {
        name: '',
        size: '',
        quantity: '1',
        hexNumber: '',
        candidateNamesList: {
          name: [
            'ラインストーン',
            'Vカットストーン',
            'スタッズ',
            '丸カン',
            'パール'
          ],
          size: ['ss3', 'ss5', 'ss9', 'ss12', 'ss16', 'ss20', 'ss26']
        }
      },
      partContent: false,
      partColorContent: false,
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
      ]
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
    selectPartName(index) {
      this.part.name = this.part.candidateNamesList.name[index]
    },
    selectPartSize(index) {
      this.part.size = this.part.candidateNamesList.size[index]
    },
    showPartContent() {
      this.partContent = !this.partContent
    },
    showPartColorContent() {
      this.partColorContent = !this.partColorContent
    },
    updatePart() {
      if (!this.part.name) {
        alert('パーツ名は登録必須です。')
        return
      }
      this.$emit(
        'update-part',
        this.part.name,
        this.part.size,
        this.part.quantity,
        this.part.hexNumber
      )
      this.part.name = ''
      this.part.size = ''
      this.part.quantity = ''
      this.part.hexNumber = ''
    }
  }
}
</script>

<style scoped>
.rotate-to-open {
  transform: rotate(90deg);
  transition: all 0.5s ease-in-out;
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
</style>
