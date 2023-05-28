<template>
  <div class="colors-input">
    <label @click="showColorContent" class="text-lg">カラーイメージ</label>
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
      <div v-show="colorContent">
        <div
          class="flex justify-around gap-2 md:gap-4 w-11/12 sm:w-8/12 my-8 sm:my-10 mx-auto">
          <button
            :class="!showColorPicker ? 'switch-color-button' : ''"
            @click="switchToColorPicker"
            class="flex-1 text-white bg-gray-800 h-12 rounded-full shadow-lg">
            カラーピッカー
          </button>
          <button
            :class="!showColorPalette ? 'switch-color-button' : ''"
            @click="switchToColorPalette"
            class="flex-1 text-white bg-gray-800 h-12 rounded-full shadow-lg">
            カラーパレット
          </button>
        </div>
        <div
          class="color-lame flex justify-start items-center w-10/12 sm:w-5/12 mx-auto mb-3">
          <label for="lame">
            <SparklesIcon
              class="show-color-content w-5 h-5 stroke-1 text-gray-400" />
          </label>
          <div>
            <label>
              <input
                type="checkbox"
                v-model="color.lame"
                id="lame"
                name="design[colors_attributes][][lame]"
                class="peer sr-only" />
              <span class="lame-toggle toggle-btn"> </span>
            </label>
            <!-- テスト用 -->
            <input
              type="radio"
              v-model="color.lame"
              :value="false"
              class="hidden" />
            <input
              type="radio"
              v-model="color.lame"
              :value="true"
              class="hidden" />
          </div>
        </div>
        <div v-show="showColorPicker">
          <div class="relative h-[244.75px]">
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
              class="color-hexnumber grid gap-2 grid-cols-6 place-items-center w-52 mx-auto">
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
        <button class="main-action-btn w-60 my-8 sm:my-10" @click="updateColor">
          決定
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { SparklesIcon } from '@heroicons/vue/24/outline'
import { PlusIcon } from '@heroicons/vue/24/outline'
import { Chrome } from '@ckpack/vue-color'
import 'color-picker-lame.png'
import 'lame.png'
export default {
  components: {
    SparklesIcon,
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
        //モノトーン
        '#000000FF',
        '#374151FF',
        '#6B7280FF',
        '#D1D5DBFF',
        '#E5E7EBFF',
        '#FFFFFFFF',
        // レッド
        '#7F1D1DFF',
        '#D52B2BFF',
        '#E27272FF',
        '#FCA5A5FF',
        '#FECACAFF',
        '#FEE2E2FF',
        // オレンジ
        '#C2410CFF',
        '#EA580CFF',
        '#FB923CFF',
        '#FDBA74FF',
        '#FED7AAFF',
        '#FFEDD5FF',
        // イエロー
        '#CA8A04FF',
        '#EAB308FF',
        '#FACC15FF',
        '#FDE047FF',
        '#FEF08AFF',
        '#FEF9C3FF',
        // グリーン
        '#14532DFF',
        '#15803DFF',
        '#22C55EFF',
        '#86EFACFF',
        '#BBF7D0FF',
        '#DCFCE7FF',
        // ブルー
        '#1E3A8AFF',
        '#1D4ED8FF',
        '#3B82F6FF',
        '#93C5FDFF',
        '#BFDBFEFF',
        '#DBEAFEFF',
        // パープル
        '#581C87FF',
        '#7E22CEFF',
        '#A855F7FF',
        '#D8B4FEFF',
        '#E9D5FFFF',
        '#F3E8FFFF',
        // ピンク
        '#831843FF',
        '#BE185DFF',
        '#EC4899FF',
        '#F9A8D4FF',
        '#FBCFE8FF',
        '#FCE7F3FF'
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
  border: 1px solid #e5e7eb;
}
.checkbox-btn {
  appearance: none;
  width: 40px;
  height: 40px;
  border: 2px solid #4b5563;
  border-radius: 50%;
  background: transparent;
  opacity: 0;
  margin: -4px 0 0 -4px;
}
.checkbox-btn:checked {
  opacity: 1;
}
</style>
