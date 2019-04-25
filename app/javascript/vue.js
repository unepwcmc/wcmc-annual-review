import Vue from 'vue/dist/vue.esm'
import Vue2TouchEvents from 'vue2-touch-events'

// store
import store from './store/store.js'

//components
import Carousel from './components/carousel/Carousel'
import Modal from './components/modal/Modal'
import ModalTrigger from './components/modal/ModalTrigger'
import NavSide from './components/nav/NavSide'
import VNav from './components/nav/VNav'

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
        Modal, 
        ModalTrigger,
        NavSide,
        VNav
      }
    })
  }
})