<template>
  <nav aria-label="site-nav">

    <div :id="mixinModalId" class="nav__item-container flex flex-v-center" :class="navType">

      <button id="close-nav-pane" class="nav__close hover--pointer" v-show="isBurgerNav" @click="closeNavPane"></button>

      <ul role="menubar" class="nav__items ul--unstyled flex">
        <li role="none" class="nav__item relative" v-for="page in pages" :key="page.id">
          
          <nav-link-scroll v-if="isScrollToNav" :item="page" v-on:click="clickNavLink"></nav-link-scroll>

          <v-nav-link v-else :item="page"></v-nav-link>

        </li>
      </ul>

    </div>

    <button :id="mixinTriggerId" class="nav__burger hover--pointer" v-show="isBurgerNav" @click="openNavPane"></button>

  </nav>
</template>

<script>
import VNavLink from "./VNavLink"
import NavLinkScroll from "./NavLinkScroll"
import mixinScrollMagic from "../../mixins/mixin-scroll-magic"
import mixinResponsive from "../../mixins/mixin-responsive"
import mixinPopupCloseListeners from "../../mixins/mixin-popup-close-listeners"
import mixinFocusCapture from "../../mixins/mixin-focus-capture"
import { disableTabbing, reenableTabbing } from '../../helpers/focus-helpers'

export default {
  components: {
    VNavLink, NavLinkScroll
  },

  mixins: [
    mixinResponsive, 
    mixinPopupCloseListeners({closeCallback: 'closeNavPane', toggleVariable: 'isNavPaneActive'}), 
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
    },
    isScrollToNav: {
      default: false,
      type: Boolean
    }
  },

  data () {
    return {
      isNavPaneActiveData: false,
      selectedDropdownId: null,
      mixinModalId: 'nav-pane',
      mixinTriggerId: 'open-nav-pane'
    }
  },

  mounted () {
    this.areNavPaneItemsVisible ? reenableTabbing(this.navPaneItemContainer) : disableTabbing(this.navPaneItemContainer)
  },

  methods: {
    openNavPane () {
      this.isNavPaneActiveData = true
    },
    
    closeNavPane () {
      this.isNavPaneActiveData = false
    },

    clickNavLink (id) {
      this.closeNavPane()
      this.scroll(id)
    }
  },

  computed: {
    isBurgerNav () {
      return this.isAlwaysBurger || !this.isLarge()
    },

    navType () {
      return { 
        'nav--pane': this.isBurgerNav,
        'nav--bar': !this.isBurgerNav,
        'nav-pane--active': this.isNavPaneActive
      }
    },

    navPaneItemContainer () {
      return this.$el.querySelector('.nav__item-container')
    },

    isNavPaneActive () {
      return this.isNavPaneActiveData && this.isBurgerNav
    },

    areNavPaneItemsVisible () {
      return !this.isBurgerNav || this.isNavPaneActive
    }
  },

  watch: {
    areNavPaneItemsVisible (visible) {
      visible ? reenableTabbing(this.navPaneItemContainer) : disableTabbing(this.navPaneItemContainer)
    }
  }
}
</script>