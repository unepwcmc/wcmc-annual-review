<template>
  <div
    class="foreword"
    :class="{ active: isActive }"
  >
    <div
      class="foreword__trigger"
      @click="toggle"
    >
      <span class="foreword__trigger-line"></span>
      <span class="foreword__trigger-line"></span>
    </div>
    <slot />
  </div>
</template>

<script>
  export default {
    name: 'foreword',

    data () {
      return {
        isActive: false
      }
    },

    methods: {
      toggle () {
        this.isActive = !this.isActive
      }
    }
  }
</script>
