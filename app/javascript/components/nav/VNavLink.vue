<template>
    <a :id="item.id" role="menuitem" class="nav__select hover--pointer" :href="item.url" @click.prevent="click">{{item.label}}</a>
</template>

<script>
export default {
  props: {
    item: {
      required: true,
      type: Object
    }
  },

  methods: {
    click () {
      this.$emit('scroll', this.item.id)
    }
  }
}
</script>
