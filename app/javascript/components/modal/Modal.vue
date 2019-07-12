<template>
  <div class="modal" :class="{ 'modal--active' : isActive }" @click.self="closeModal">
    <div role="dialog" aria-modal="true" class="modal__dialog">

      <div class="modal__content">
        <button class="modal__close" @click="closeModal"></button>
        
        <div class="container--small">
          <h3>{{ data.title }}</h3>
        </div>

        <template v-for="section, index in content">
          <div class="container--small">
            <h4 v-if="hasTitle(section)">{{ section.title }}</h4>
            <p v-for="p in section.text" v-html="p"></p>
          </div>

          <div v-if="index == 0" class="modal__bg-image item-margin--top item-margin--bottom" :style="{ 'background-image': `url(${data.modal.image})` }"></div>
        </template>
        
        <div class="modal__staff item-padding item-margin--top">
          <div v-for="member in staff" class="modal__staff-member flex">
            <img :src="member.image" :alt="`Profile image of ${member.name}`" class="modal__staff-image" />
            <div>
              <p class="no-margin"><strong>{{ member.name }}<br>{{ member.job }}</strong></p>
              <p v-html="member.text"></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { eventHub } from '../../vue.js'
import mixinFocusCapture from '../../mixins/mixin-focus-capture'
import mixinPopupCloseListeners from '../../mixins/mixin-popup-close-listeners'

export default {
  name: 'modal',

  mixins: [
    mixinFocusCapture({toggleVariable: 'isActive', closeCallback: 'closeModal'}), 
    mixinPopupCloseListeners({closeCallback: 'closeModal', closeOnClickOutside: false})
  ],

  props: {
    id: {
      type: String,
      required: true
    }
  },

  computed: {
    isActive () {
      return this.$store.state.modal.isActive
    },

    mixinTriggerId () {
      return 'modal-trigger-' + this.id
    },

    data () {
      return this.$store.state.modal.content
    },

    content () {
      return this.data.modal && this.data.modal.content ? this.data.modal.content : false
    },

    staff () {
      return this.data.modal && this.data.modal.staff ? this.data.modal.staff : false
    }
  },

  methods: {
    toggleModal () {
      this.$store.dispatch('modal/closeModal')
    },

    closeModal () {
      this.toggleModal()
    },

    hasTitle (content) {
      return content.title
    }
  }
}
</script>