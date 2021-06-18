<template>
  <li :class="['carousel-slide', 'transition']">
    <slot :slideScope="slideScope"></slot>
  </li>
</template>

<script>
import { getInputs } from '../../helpers/focus-helpers';
import { eventHub } from '../../vue';
import '../../mixins/mixin-responsive';

export default {
  name: 'carousel-slide',

  props: {
    slidesPerFrame: {
      default: 1,
      type: Number
    },
    marginSize: {
      default: 10,
      type: Number
    }
  },

  data () {
    return {
      slideScope: {},
      isActive: false,
      inputElements: []
    }
  },

  mounted () {
    this.setSlideStyle()
    this.inputElements = getInputs(this.$el)
    this.setTabIndices()

    eventHub.$on('windowResized', this.setSlideStyle)
  },

  watch: {
    isActive () {
      this.setTabIndices() 
    }
  },

  computed: {
    impacts () { return this.$parent.$el.id == 'impacts' },
  },

  methods: {
    setTabIndices() {
      const tabIndex = this.isActive ? 0 : -1

      Array.prototype.forEach.call(this.inputElements, el => {
        el.tabIndex = tabIndex
        if(tabIndex === -1) { el.blur() }
      })
    },

    setSlideStyle () {
      const style = this.$el.style

      if (this.impacts) {
        this.slidesPerFrame = screen.width > 720 ? (2/3) : 1
      }
      
      style.marginLeft = style.marginRight = this.marginSize + 'px'
      style.width = `calc(${100/this.slidesPerFrame}% - ${2*this.marginSize}px)`
    }
  }
}
</script>