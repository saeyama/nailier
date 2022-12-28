<template>
  <div>
    <label class="text-lg" for=""><slot name="label">label</slot></label>
    <div class="flex gap-2">
      <input
        class="form-field my-auto"
        type="text"
        :placeholder="placeholder"
        v-model="value"
        @input="inputValue" />
      <button
        class="text-white bg-gray-800 w-24 h-12 rounded-full shadow-lg"
        @click="updateValue">
        決定
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ChildTextInput',
  props: {
    placeholder: { type: String, required: false }
  },
  data() {
    return {
      value: ''
    }
  },
  methods: {
    inputValue(e) {
      this.$emit('input-value', e.target.value)
    },
    updateValue() {
      this.$emit('update-value', this.value)
      this.value = ''
    }
  }
}
</script>
