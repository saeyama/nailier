<template>
  <div class="parts-input">
    <label @click="showPartContent" class="text-lg border-solid">パーツ</label>
    <div class="border border-gray-200 rounded mt-1">
      <div
        @click="showPartContent"
        class="px-1 py-2 sm:p-2 mx-2 flex justify-between items-start cursor-pointer">
        <span>登録する</span>
        <PlusIcon
          :class="
            partContent
              ? 'rotate-45 transition duration-500 ease-in-out'
              : 'transition duration-500 ease-in-out'
          "
          class="show-part-content w-6 h-6 stroke-1" />
      </div>
      <hr :class="partContent ? '' : 'hidden'" />
      <div class="mx-2 sm:mx-4 mt-6" v-show="partContent">
        <input
          class="form-field px-2 sm:px-4"
          type="text"
          name="design[parts_attributes][][name]"
          id="design-part-name"
          placeholder="パーツ名を入力or下記より選択"
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
          class="form-field px-2 sm:px-4"
          type="text"
          name="design[parts_attributes][][size]"
          id="design-part-size"
          placeholder="大きさを入力or下記より選択"
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
          class="flex justify-between items-center mb-6 rounded border border-gray-200 py-1 px-4">
          <label for="design-part-quantity">個数</label>
          <input
            class="form-field w-20 h-8 rounded"
            type="number"
            name="design[parts_attributes][][quantity]"
            id="design-part-quantity"
            min="1"
            onkeypress="return (event.charCode === 8 || event.charCode === 46) ? null : event.charCode >= 48 && event.charCode <= 57"
            v-model="part.quantity" />
        </div>
        <div class="border border-gray-200 rounded">
          <div
            @click="showPartColorContent"
            class="flex justify-between items-center w-full px-2 sm:px-4 py-2">
            <label>カラー</label>
            <ChevronRightIcon
              :class="
                partColorContent
                  ? 'rotate-90 transition duration-500 ease-in-out'
                  : 'transition duration-500 ease-in-out'
              "
              class="show-part-color-content w-6 h-6 stroke-1" />
          </div>
          <hr :class="partColorContent ? '' : 'hidden'" />
          <div class="py-6" v-show="partColorContent">
            <ul
              class="part-hexnumber grid gap-2 grid-cols-6 place-items-center w-52 mx-auto">
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
        </div>
        <button class="main-action-btn w-60 my-8 sm:my-10" @click="updatePart">
          決定
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { PlusIcon } from '@heroicons/vue/24/outline'
import { ChevronRightIcon } from '@heroicons/vue/24/outline'
export default {
  components: {
    PlusIcon,
    ChevronRightIcon
  },
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
      ]
    }
  },
  computed: {
    colorShowHexNumber: () => (hexNumber) => ({
      'background-color': hexNumber
    })
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
      this.part.quantity = '1'
      this.part.hexNumber = ''
    }
  }
}
</script>

<style scoped>
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
