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
        v-model="value" />
      <button
        class="text-white bg-gray-800 w-24 h-11 rounded-full shadow-lg"
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
    placeholder: { type: String, required: true },
    name: { type: String, required: true },
    id: { type: String, required: true }
  },
  data() {
    return {
      value: ''
    }
  },
  methods: {
    updateValue() {
      this.$emit('update-value', this.value)
      this.value = ''
    }
  }
}
</script>
