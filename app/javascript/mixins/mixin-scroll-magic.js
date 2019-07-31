import ScrollMagic from 'scrollmagic'
import smoothscroll from 'smoothscroll-polyfill'

smoothscroll.polyfill()

export default {
  mounted () {
    this.setTriggerOffset()
    this.scrollMagicHandlers()
    this.updateScrollMagicDurations()
  },

  computed: {
    supportsNativeSmoothScroll() {
      return 'scrollBehavior' in document.documentElement.style
    }
  },

  methods: {
    currentEvent () {
      const event = document.getElementById('v-current-event')
      
      if(event) {
        const location = window.pageYOffset + event.getBoundingClientRect().top - this.triggerOffset - 10

        this.$store.commit('filters/updateCurrentEvent', location)

        eventHub.$emit('backToTop')
      }
    },

    // scroll down to the section of the page which corresponds to the
    // link that has been clicked
    scroll (id) {
      const offset = document.getElementById('section-' + id).offsetTop,
        top = offset - this.triggerOffset

      if(this.supportsNativeSmoothScroll) {
        window.scrollTo({ top: top, behavior: 'smooth' })
      } else {
        window.scroll({ top: top, left: 0, behavior: 'smooth' });
      }
    },

    // add scroll magic event listener for each nav item
    // so that the nav items change active state when scrolling
    // through different sections on the page
    scrollMagicHandlers () {
      let navScrollMagic = new ScrollMagic.Controller()
      let scrollMagicScenes = []

      // add scene for each item in the nav
      this.pages.forEach(link => {
        let sideNav = {},
          stickyBar = {}
        const id = link.id

        sideNav.id = id
        stickyBar.id = id + '-sticky'

        sideNav.scene = new ScrollMagic.Scene({ 
          triggerElement: '#section-' + id,
        })
        .setClassToggle('#scroll-link-' + id, 'nav__link--active')
        .addTo(navScrollMagic)

        stickyBar.scene = new ScrollMagic.Scene({ 
          triggerElement: '#section-' + id,
        })
        .triggerHook('onLeave')
        .offset(-this.triggerOffset)
        .setClassToggle('.sm-target-scroll', 'topbar--' + id)
        .addTo(navScrollMagic)

        scrollMagicScenes.push(sideNav)
        scrollMagicScenes.push(stickyBar)
      })

      this.scrollMagicScenes = scrollMagicScenes
    },

    setTriggerOffset () {
      // this offset accounts for the sticky bars at the top of the window
      this.triggerOffset = document.querySelector('.sm-target-sticky').clientHeight
    },

    updateScrollMagicDurations () {
      // update the scene durations (year div heights)
      this.scrollMagicScenes.forEach(scene => {
        let section = document.getElementById('section-' + scene.id)
        let height = 0
        
        if(section) height = section.clientHeight

        scene.scene.duration(height)
      })
    },

    windowResized () {
      // when the window width is resized the heights of the sticky bars and
      // years will change so update js accordingly
      const newWidth = window.innerWidth

      if(newWidth > this.windowWidth || newWidth < this.windowWidth) {
        this.setTriggerOffset()
        this.updateScrollMagicDurations()
        this.currentEvent()
        eventHub.$emit('getScrollY')

        this.windowWidth = newWidth
      }
    }
  }
}