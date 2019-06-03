<template>
  <g> 
    <path 
      :d="path" 
      :fill="fillColour" 
      :stroke="colour.line" 
      :stroke-width="StrokeWidth" />
    
    <template v-if="legend">
      <circle :cx="middle.x" :cy="middle.y" :fill="colour.line" r="18">{{ index + 1 }}</circle>
      <text :x="middle.x" :y="middle.y" :fill="colour.text" text-anchor="middle" dominant-baseline="middle" :font-size="fontSize" :font-weight="fontWeight">{{ index + 1 }}</text>
    </template>
  </g>
</template>

<script>
export default {
  name: 'chart-line-dataset',

  props: {
    path: {
      type: String,
      required: true
    },
    index: {
      type: Number,
      required: true
    },
    colour: {
      type: Object,
      required: true
    },
    middle: {
      type: Object,
      required: true
    },
    fontSize : {
      type: Number,
      default: 18
    },
    fontWeight : {
      type: Number,
      default: 900
    },
    legend: {
      type: Boolean,
      default: false
    },
    fill: {
      type: Boolean,
      default: false
    }
  },

  computed: {
    fillColour () {
      return this.fill ? this.colour : 'none'
    },

    strokeWidth () {
      return this.fill ? 1 : 6
    }
  }
}
</script>