<template>
  <div class="flex flex-v-center" @click="click">
    <span class="carousel__nav-text">{{ item.label }}</span>
    <span role="menuitem" class="nav__button"></span>
  </div>
</template>

<script>
export default {
  name: 'name-link-scroll',

  props: {
    item: {
      required: true,
      type: Object
    }
  },

  methods: {
    click () {
      console.log(this.item.id)
      this.$emit('click', this.item.id)
    }
  }
}
</script>
