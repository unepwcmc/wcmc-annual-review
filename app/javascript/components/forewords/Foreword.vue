<template>
  <div
    class="foreword"
    :class="{ active: isActive }"
  >
    <button
      type="button"
      class="foreword__trigger"
      @click="onForewordTriggerClick"
    >
      <span class="foreword__trigger-line"></span>
      <span class="foreword__trigger-line"></span>
    </button>
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
      onForewordTriggerClick () {
        this.expandForeword()
      },
      expandForeword () {
        this.isActive = !this.isActive
      }
    }
  }
</script>
