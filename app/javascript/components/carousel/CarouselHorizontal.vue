<template>
  <div :id="slidesWrapperId" :class="['slides-wrapper', slidesWrapperId]">
    <div :id="slidesId" :class="['slides', slidesId]">
      <div v-for="slide in slides" :id="slideId" :class="['slide', slideId]" :style="{ 'width': slideWidth + '%'}">
        <h3>{{ slide.title }}</h3>
        <p>{{ slide.introduction }}</p>
      </div>
    </div>
  </div>
</template>

<script>
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
          speed: '300%'
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
      }
    },

    mounted () {
      this.scrollMagicHandlers()
    },

    methods: {
      scrollMagicHandlers () {
        const controller = new ScrollMagic.Controller(),
          timeline = new TimelineMax()

        for(let i = 0; i < this.totalSlides - 1; i++) {
          
          let x = -(i+1) * this.slideWidth + '%'

          timeline.to(`#${this.slidesId}`, 1, {x: x})
        }

        new ScrollMagic.Scene({
            triggerElement: `#${this.slidesWrapperId}`,
            triggerHook: 'onLeave',
            duration: this.config.speed
          })
          .setPin(`#${this.slidesWrapperId}`)
          .setTween(timeline)
          .addTo(controller)
      }
    }
  }
</script>