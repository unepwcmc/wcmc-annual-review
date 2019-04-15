import Vue from 'vue/dist/vue.esm'
import Vue2TouchEvents from 'vue2-touch-events'

import VNav from './components/nav/VNav'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

document.addEventListener('DOMContentLoaded', () => { 
  if(document.getElementById('v-app')) {

    Vue.use(Vue2TouchEvents)

    const app = new Vue({
      el: '#v-app',

      components: {
        VNav
      }
    })
  }
})