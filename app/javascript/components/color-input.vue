<template>
  <div class="colors-input">
    <div class="text-lg border-solid">カラーイメージ</div>
    <div class="border border-gray-200 rounded mt-1">
      <div
        @click="showColorContent"
        class="px-1 py-2 sm:p-2 mx-2 flex justify-between items-start cursor-pointer">
        <span>登録する</span>
        <PlusIcon
          :class="
            colorContent
              ? 'rotate-45 transition duration-500 ease-in-out'
              : 'transition duration-500 ease-in-out'
          "
          class="show-color-content w-6 h-6 stroke-1" />
      </div>
      <hr :class="colorContent ? '' : 'hidden'" />
      <div class="mb-4" v-show="colorContent">
        <div class="my-4 md:mb-8 pl-2 md:pl-8">
          ラメ&emsp;
          <lable
            >なし&nbsp;
            <input
              type="radio"
              v-model="color.lame"
              name="design[colors_attributes][][lame]"
              :value="false"
              id="false" />
          </lable>
          &emsp;
          <lable
            >あり&nbsp;
            <input
              type="radio"
              v-model="color.lame"
              name="design[colors_attributes][][lame]"
              :value="true"
              id="true" />
          </lable>
        </div>
        <div
          class="flex justify-around gap-2 md:gap-4 mb-6 md:mb-10 max-w-xl mx-2 sm:mx-auto">
          <button
            :class="!showColorPicker ? 'switch-color-button' : ''"
            @click="switchToColorPicker"
            class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
            カラーピッカー
          </button>
          <button
            :class="!showColorPalette ? 'switch-color-button' : ''"
            @click="switchToColorPalette"
            class="flex-1 text-white bg-gray-800 border-0 h-12 rounded-full shadow-lg">
            カラーパレット
          </button>
        </div>
        <div v-show="showColorPicker">
          <div class="relative h-64">
            <img
              src="~color-picker-lame.png"
              alt="ラメ"
              v-if="colorLameStyle"
              class="absolute z-10 top-0 left-1/2 -translate-x-1/2 pointer-events-none" />
            <chrome-picker
              class="absolute z-0 top-0 left-1/2 -translate-x-1/2"
              :value="color.pickerHexNumber"
              name="design[colors_attributes][][hex_number]"
              v-model="color.pickerHexNumber">
            </chrome-picker>
          </div>
        </div>
        <div v-show="showColorPalette">
          <div class="relative">
            <ul
              class="color-hexnumber grid gap-2 grid-cols-5 place-items-center w-48 mx-auto">
              <li
                v-for="(hexNumber, index) in colorPaletteHexNumbers"
                :key="index"
                :style="colorShowHexNumber(hexNumber)"
                name="design[colors_attributes][][hex_number]"
                class="w-8 h-8 rounded-full cursor-pointer shadow-md">
                <img
                  src="~lame.png"
                  alt="ラメ"
                  v-if="colorLameStyle"
                  class="absolute z-10 w-8 h-8 rounded-full opacity-80 pointer-events-none" />
                <input
                  type="radio"
                  v-model="color.paletteHexNumber"
                  :value="hexNumber"
                  class="checkbox-btn" />
              </li>
            </ul>
          </div>
        </div>
        <button
          class="main-action-btn mt-4 mb-6 md:mt-6 md:mb-8"
          @click="updateColor">
          決定
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { PlusIcon } from '@heroicons/vue/24/outline'
import { Chrome } from '@ckpack/vue-color'
import 'color-picker-lame.png'
import 'lame.png'
export default {
  components: {
    PlusIcon,
    'chrome-picker': Chrome
  },
  name: 'ColorInput',
  data() {
    return {
      color: {
        lame: false,
        pickerHexNumber: '#FF7003',
        paletteHexNumber: '',
        hexNumberHex8: ''
      },
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
      ],
      showColorPicker: true,
      showColorPalette: false,
      colorContent: false
    }
  },
  computed: {
    colorShowHexNumber: () => (hexNumber) => ({
      'background-color': hexNumber
    }),
    colorLameStyle() {
      return this.color.lame
    }
  },
  methods: {
    showColorContent() {
      this.colorContent = !this.colorContent
    },
    switchToColorPicker() {
      this.showColorPicker = true
      this.showColorPalette = false
    },
    switchToColorPalette() {
      this.showColorPalette = true
      this.showColorPicker = false
    },
    updateColor() {
      this.$emit(
        'update-color',
        this.color.lame,
        this.color.pickerHexNumber,
        this.color.paletteHexNumber,
        this.color.hexNumberHex8
      )
      this.color.lame = false
      this.color.pickerHexNumber = '#FF7003'
      this.color.paletteHexNumber = ''
      this.color.hexNumberHex8 = ''
    }
  }
}
</script>

<style scoped>
.switch-color-button {
  background: #ffffff;
  color: #4b5563;
  border: 1px solid #d1d5db;
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
