<template>
  <li :class="['carousel-slide', 'transition']">
    <slot :slideScope="slideScope"></slot>
  </li>
</template>

<script>
import { getInputs } from '../../helpers/focus-helpers';
import mixinResponsive from '../../mixins/mixin-responsive';

export default {
  name: 'carousel-slide',
  mixins: [mixinResponsive],

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
    if (!this.isSmall() && this.isImpactsCarousel) { 
      this.setSlideStyle(1.15)
    } else { 
      this.setSlideStyle()
    }

    this.inputElements = getInputs(this.$el)
    this.setTabIndices()
  },

  watch: {
    isActive () {
      this.setTabIndices() 
    },

    currentBreakpoint () {
      const isSmall = this.isSmall();
      if (this.isImpactsCarousel) {
        this.setSlideStyle(isSmall ? 1 : 1.15)
      }
    }
  },

  computed: {
    isImpactsCarousel () { return this.$parent.$el.id == 'impacts'}
  },

  methods: {
    setTabIndices() {
      const tabIndex = this.isActive ? 0 : -1

      Array.prototype.forEach.call(this.inputElements, el => {
        el.tabIndex = tabIndex
        if(tabIndex === -1) { el.blur() }
      })
    },

    setSlideStyle (slidesPerFrame = this.slidesPerFrame) {
      const style = this.$el.style

      style.marginLeft = style.marginRight = this.marginSize + 'px'
      style.width = `calc(${100/slidesPerFrame}% - ${2*this.marginSize}px)`
    }
  }
}
</script>