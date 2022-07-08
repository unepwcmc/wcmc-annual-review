<template>
  <nav aria-label="site-nav" class="nav--side flex">
    <ul role="menubar" class="nav__items ul--unstyled flex flex-column">
      <li role="none" class="nav__item relative" v-for="page in pages" :key="page.id">
        <nav-link-scroll :item="page" v-on:click="scroll"></nav-link-scroll>
      </li>
    </ul>
  </nav>
</template>

<script>
import NavLinkScroll from "./NavLinkScroll"
import mixinScrollMagic from "../../mixins/mixin-scroll-magic"
import mixinResponsive from "../../mixins/mixin-responsive"
import mixinFocusCapture from "../../mixins/mixin-focus-capture"
import { disableTabbing, reenableTabbing } from '../../helpers/focus-helpers'

export default {
  name: 'nav-side',

  components: {
    NavLinkScroll
  },

  mixins: [
    mixinResponsive, 
    mixinFocusCapture({toggleVariable: 'isNavPaneActive', closeCallback: 'closeNavPane', openCallback: 'openNavPane'}),
    mixinScrollMagic
  ],

  props: {
    pages: {
      required: true,
      type: Array
    },
    isAlwaysBurger: {
      default: false,
      type: Boolean
    }
  },

  data () {
    return {
      
    }
  },

  mounted () {
    
  },

  methods: {
    
  },

  computed: {
    isBurgerNav() {
      
    },

    navType() {
      return { 
        'nav--pane': this.isBurgerNav,
        'nav--bar': !this.isBurgerNav,
        'nav-pane--active': this.isNavPaneActive
      }
    },
  }
}
</script>