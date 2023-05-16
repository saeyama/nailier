<template>
  <div>
    <label :for="id" class="text-lg"><slot name="label">label</slot></label>
    <div class="flex gap-2">
      <input
        class="form-field my-auto"
        type="text"
        :placeholder="placeholder"
        :name="name"
        :id="id"
        v-model="value"
        @input="inputValue" />
      <button
        class="text-white bg-gray-800 w-24 h-12 rounded-full shadow-lg"
        @click="updateValue">
        決定
      </button>
    </div>
    <p class="mt-0.5 text-xs">
      <slot name="description">description</slot>
    </p>
  </div>
</template>

<script>
export default {
  name: 'ChildTextInput',
  props: {
    for: { type: String, required: false },
    placeholder: { type: String, required: false },
    name: { type: String, required: false },
    id: { type: String, required: false }
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
