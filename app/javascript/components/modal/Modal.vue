<template>
  <div class="modal" :class="{ 'modal--active' : isActive }" @click.self="closeModal">
    <div role="dialog" aria-modal="true" class="modal__dialog">

      <div class="modal__content">
        <button class="button--plain modal__close" @click="closeModal">
          <span>close</span>
        </button>

        <h3>{{ content.title }}</h3>
        <p>{{ content.introduction }}</p>
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

    content () {
      return this.$store.state.modal.content
    }
  },

  methods: {
    toggleModal () {
      this.$store.dispatch('modal/closeModal')
    },

    closeModal () {
      this.toggleModal()
    }
  }
}
</script>