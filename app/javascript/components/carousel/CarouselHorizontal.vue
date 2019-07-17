<template>
  <div :id="slidesWrapperId" :class="['slides-wrapper', slidesWrapperId]">
    <div :id="slidesId" :class="['slides', slidesId]" :style="{ 'width': slidesWidth + '%'}">
      <div v-for="slide, index in slides" :id="slideId" :class="['slide', slideId]" :style="{ 'width': slideWidth + '%'}">
        <div class="slide__image" :style="{ 'background-image': `url(${slide.image})` }"></div>
        <div class="slide__content">
          <h3 class="slide__title">{{ slide.title }}</h3>
          <p v-for="p in slide.introduction" v-html="p" class="slide__introduction"></p>
          <span class="slide__index">{{ index + 1 }} of {{ totalSlides }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { BREAKPOINTS } from '../../constants/constants-breakpoints.js'
  import { TimelineMax } from 'gsap'
  import ScrollMagic from 'scrollmagic'
  import 'imports-loader?define=>false!scrollmagic/scrollmagic/uncompressed/plugins/animation.gsap'

  export default {
    name: 'carousel',

    props: {
      id: {
        type: String,
        required: true
      },
      slides: {
        type: Array,
        required: true
      }
    },

    data () {
      return {
        config: {
          speed: '300%',
          offset: {
            mobile: '-70px',
            tablet: '-120px',
            laptop: '-180px',
            desktop: '-180px'
          }
        }
      }
    },

    computed: {
      slidesWrapperId () {
        return `slides-wrapper--${this.id}`
      },

      slidesId () {
        return `slides--${this.id}`
      },

      slideId () {
        return `slide--${this.id}`
      },

      totalSlides () { 
        return this.slides.length
      },

      slideWidth () {
        return Math.floor(100/this.totalSlides)
      },

      slidesWidth () {
        return Math.floor(this.totalSlides*100*.78)
      }
    },

    mounted () {
      this.scrollMagicHandlers()

      window.onresize = this.windowResized
    },

    methods: {
      scrollMagicHandlers () {
        this.windowWidth = window.innerWidth
        
        const controller = new ScrollMagic.Controller(),
          timeline = new TimelineMax(),
          offset = this.getOffset()

        for(let i = 0; i < this.totalSlides - 1; i++) {
          
          let x = -(i+1) * this.slideWidth + '%'

          timeline.to(`#${this.slidesId}`, 1, {x: x})
        }

        this.scrollMagicScene = new ScrollMagic.Scene({
            triggerElement: `#${this.slidesWrapperId}`,
            triggerHook: 'onLeave',
            offset: offset,
            duration: this.config.speed
          })
          .setPin(`#${this.slidesWrapperId}`)
          .setTween(timeline)
          .addTo(controller)
      },

      updateScrollMagicScene () {
        this.scrollMagicScene.removePin(true)

        const offset = this.getOffset()

        this.scrollMagicScene.offset(offset)
        this.scrollMagicScene.setPin(`#${this.slidesWrapperId}`)
        this.scrollMagicScene.refresh()
      },

      windowResized () {
        this.windowWidth = window.innerWidth
        this.updateScrollMagicScene()
      },

      getOffset() {
        const size = this.getScreenSize()
        let offset = 0

        if(size) { offset = this.config.offset[size] }

        return offset
      },

      getScreenSize() {
        let size = ''

        if(this.windowWidth <= BREAKPOINTS.small) {
          size = 'mobile'
        } else if(this.windowWidth > BREAKPOINTS.small && this.windowWidth <= BREAKPOINTS.medium) {
          size = 'tablet'
        } else if(this.windowWidth > BREAKPOINTS.medium && this.windowWidth <= BREAKPOINTS.large) {
          size = 'laptop'
        } else if(this.windowWidth > BREAKPOINTS.large) {
          size = 'desktop'
        } else {
          size = false
        }

        return size
      }
    }
  }
</script>