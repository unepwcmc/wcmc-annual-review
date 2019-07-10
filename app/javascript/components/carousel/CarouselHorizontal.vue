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
      },

      slidesWidth () {
        return Math.floor(this.totalSlides*100*.72)
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
            offset: '-180px',
            duration: this.config.speed
          })
          .setPin(`#${this.slidesWrapperId}`)
          .setTween(timeline)
          .addTo(controller)
      }
    }
  }
</script>