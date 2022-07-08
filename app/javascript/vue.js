import { polyfill } from 'es6-object-assign'
polyfill()

import Vue from 'vue/dist/vue.esm'
import Vue2TouchEvents from 'vue2-touch-events'

// store
import store from './store/store.js'

//components
import Carousel from './components/carousel/Carousel'
import CarouselHorizontal from './components/carousel/CarouselHorizontal'
import CarouselSlide from './components/carousel/CarouselSlide'
import ChartLineArea from './components/charts/ChartLineArea'
import ChartLineLabelled from './components/charts/ChartLineLabelled'
import Foreword from './components/forewords/Foreword'
import Modal from './components/modal/Modal'
import ModalTrigger from './components/modal/ModalTrigger'
import NavSide from './components/nav/NavSide'
import VNav from './components/nav/VNav'
import SocialShare from './components/social/SocialShare'
import StickyBar from './components/sticky/StickyBar'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('v-app')) {

    Vue.use(Vue2TouchEvents)

    const app = new Vue({
      el: '#v-app',

      store,

      components: {
        Carousel,
        CarouselHorizontal,
        CarouselSlide,
        ChartLineArea,
        ChartLineLabelled,
        Foreword,
        Modal,
        ModalTrigger,
        NavSide,
        VNav,
        SocialShare,
        StickyBar
      }
    })
  }
})
