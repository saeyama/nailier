<template>
  <div>
    <div class="flex justify-center gap-x-2 mx-auto">
      <div v-for="option in options" :key="option">
        <label :for="option.label" class="block flex-1 cursor-pointer">
          <input
            type="radio"
            :name="name"
            :id="option.label"
            :value="option.value"
            :checked="option.value === modelValue"
            @change="selectValue"
            class="peer sr-only" />
          <span
            :class="option.label"
            class="w-20 h-10 flex justify-center items-center text-center border border-gray-200 rounded peer-checked:bg-gray-800 peer-checked:text-white">
            {{ option.value }}
          </span>
        </label>
      </div>
    </div>
    <p class="text-xs text-center my-2">ネイルパート：{{ modelValue }}</p>
  </div>
</template>

<script>
export default {
  name: 'NailpartRadioBtn',
  props: {
    options: { type: Array, required: true },
    name: { type: String, required: true },
    modelValue: { type: String, required: true }
  },
  methods: {
    selectValue(e) {
      this.$emit('update:modelValue', e.target.value)
    }
  }
}
</script>
