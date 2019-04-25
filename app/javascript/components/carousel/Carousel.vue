<template>
  <div :id="slidesWrapperId" :class="['slides-wrapper', slidesWrapperId]">
    <div :id="slidesId" :class="['slides', slidesId]">
      <div v-for="slide in slides" :id="slideId" :class="['slide', slideId]">
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

    computed: {
      slidesWrapperId () {
        return `slides-wrapper--${this.id}`
      },

      slidesId () {
        return `slides--${this.id}`
      },

      slideId () {
        return `slide--${this.id}`
      }
    },

    mounted () {
      this.scrollMagicHandlers()
    },

    methods: {
      scrollMagicHandlers () {
        let controller = new ScrollMagic.Controller()

        let wipeAnimation = new TimelineMax()
          .to(`#${this.slidesId}`, 1, {x: "-33%"})
          .to(`#${this.slidesId}`, 1, {x: "-66%"})

        new ScrollMagic.Scene({
            triggerElement: `#${this.slidesWrapperId}`,
            triggerHook: 'onLeave',
            duration: '300%'
          })
          .setPin(`#${this.slidesWrapperId}`)
          .setTween(wipeAnimation)
          .addTo(controller)
      }
    }
  }
</script>