<template>
  <div class="slides--c">
    <div class="slides--h">
      <div v-for="slide in slides " class="slide--h">
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
      slides: {
        type: Array,
        required: true
      }
    },

    mounted () {
      this.scrollMagicHandlers()
    },

    methods: {
      scrollMagicHandlers () {
        let controller = new ScrollMagic.Controller()

        let wipeAnimation = new TimelineMax()
          .to('.slides--h', 1, {x: "-33%"})
          .to('.slides--h', 1, {x: "-66%"})

        new ScrollMagic.Scene({
            triggerElement: '.slides--c',
            triggerHook: 'onLeave',
            duration: '300%'
          })
          .setPin('.slides--c')
          .setTween(wipeAnimation)
          .addTo(controller)
      }
    }
  }
</script>