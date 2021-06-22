import { eventHub } from '../vue'

export default {
  data () {
    return {
      windowWidth: 0,
      currentBreakpoint: '',
      breakpoints: {
        xs: 640,
        small: 720,
        medium: 1024,
        large: 1708
      }
    }
  },

  created () {
    this.updateWindowSize()

    // allow for multiple functions to be called on window resize
    window.addEventListener('resize', () => eventHub.$emit('windowResized'))

    eventHub.$on('windowResized', this.updateWindowSize)
  },

  methods: {
    updateWindowSize () {
      this.windowWidth = window.innerWidth

      if(this.isSmall()) { this.currentBreakpoint = 'small' }
      if(this.isMedium()) { this.currentBreakpoint = 'medium' }
      if(this.isLarge()) { this.currentBreakpoint = 'large' }
    },

    isSmall () {
      return this.windowWidth <= this.breakpoints.small
    },

    isMedium () {
      return this.windowWidth > this.breakpoints.small && this.windowWidth <= this.breakpoints.medium
    },

    isLarge () {
      return this.windowWidth > this.breakpoints.medium
    },

    getCurrentBreakpoint () {
      return this.currentBreakpoint
    }
  }
}
