<template>
  <div class="chart--line">
    <div class="chart__wrapper-ie11">
      <div class="chart__scrollable">
        <div v-if="lines" class="chart__chart" style="width:100%;">
          <svg width="100%" height="100%" :viewBox="`-${chartPaddingSides} -${svgPaddingTop} ${svg.width} ${svg.height}`" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" class="chart__svg">
            <rect 
              :x="-chartPaddingSides"
              :y="`-${chartPaddingTop}`" 
              :width="svg.width" 
              :height="backgroundHeight" 
              :fill="backgroundColour" />

            <text v-if="axisLabels" :x="-chartPaddingSides" :y="-4.5 * fontSize" :font-size="fontSize">
              <tspan v-for="t in axisLabels.y" :x="-chartPaddingSides" :dy="1.25 * fontSize">{{ t }}</tspan>
            </text>

            <text v-for="y in yAxis" 
              :x="-chartPaddingLeft" 
              :y="y.coord"
              text-anchor="end"
              fill="white"
              :font-size="fontSize">{{ y.labelText }}</text>

            <text v-for="x in xAxis" 
              :x="x.coord" 
              :y="xAxisYDisplacement" 
              :font-size="fontSize"
              fill="white"
              text-anchor="middle">{{ x.labelText }}</text>

            <chart-line-dataset 
              v-for="line, index in lines"
              :index="index"
              <!-- :path="getPath(line.datapoints)" -->
              :dataset="line.dataset"
              <!-- :middle="getPathMiddle(line.datapoints)" -->
              :colour="getLineColourPair(line)"
              :legend="false"
              :fill="true">
            </chart-line-dataset>
          </svg>
        </div>
      </div>
    </div>

    <chart-legend v-if="hasLegend" :is-line="true" :legend-items="legendDatasets"></chart-legend>
  </div>  
</template>

<script>
import ChartLineDataset from './ChartLineDataset'

const AXIS_PADDING = 30
const DEFAULT_BACKGROUND_COLOUR = 'transparent'
const DEFAULT_CHART_PADDING_SIDES = 80
const DEFAULT_FONT_SIZE = 14
const DEFAULT_LINE_COLOUR = {
  line: '#000000',
  text: '#ffffff'
}
const DEFAULT_SVG_CONFIG = {
  width: 1000,
  height: 650
}
const DEFAULT_X_AXIS_CONFIG = {
  precision: 1,
  axisMarks: 10
}
const DEFAULT_Y_AXIS_CONFIG = {
  precision: 1,
  axisMarks: 8
}

export default {
  name: 'chart-line-area',

  components: { ChartLineDataset },

  props: {
    lines: {
      type: Array, // Line[]
      required: true
    },
    xTargets: Array,
    yTargets: Array,
    axisLabels: Object,
    hasLegend: {
      type: Boolean,
      default: false
    },
    fontSize: {
      default: DEFAULT_FONT_SIZE,
      type: Number
    },
    xAxisConfig: Object,
    yAxisConfig: Object,
    chartPaddingSides: {
      type: Number,
      default: DEFAULT_CHART_PADDING_SIDES
    },
    backgroundColour: {
      type: String,
      default: DEFAULT_BACKGROUND_COLOUR
    },
    svgConfig: Object
  },

  computed: {
    x () { return {...DEFAULT_X_AXIS_CONFIG, ...this.xAxisConfig} },

    y () { return {...DEFAULT_Y_AXIS_CONFIG, ...this.yAxisConfig} },

    svg () { return {...DEFAULT_SVG_CONFIG, ... this.svgConfig} },

    yAxis () { return this.getAxis('y') },

    xAxis () { return this.getAxis('x') },

    backgroundHeight () {return this.svg.height - this.svgPaddingTop },

    chartHeight () {return this.backgroundHeight - this.chartPaddingTop - this.fontSize - this.chartPaddingBottom },

    chartWidth () {return this.svg.width - 2 * this.chartPaddingSides },

    chartPaddingBottom () { return this.fontSize + AXIS_PADDING },

    chartPaddingLeft () { return AXIS_PADDING },

    chartPaddingTop () { return this.fontSize * 1.5 },

    svgPaddingTop () {return this.chartPaddingTop + this.fontSize * 3 },

    xAxisYDisplacement () { return this.chartHeight + this.chartPaddingBottom },

    legendDatasets () {
      const legendDatasets = []

      if (this.lines.length) {
        this.lines.forEach(line => {
          const legendDataset = {
            ...line,
            colour: this.getLineColourPair(line).line
          }

          legendDatasets.push(legendDataset)
        })
      }

      return legendDatasets
    }
  },

  created () {
    // this.x.min = this.getMinMax('min', 'x')
    // this.x.max = this.getMinMax('max', 'x')
    // this.y.min = 0
    // this.y.max = this.getMinMax('max', 'y')
  },

  methods: {
    // getPath(dataset) {
    //   let path = ''

    //   path += `M ${this.normaliseX(this.x.max)} ${this.normaliseY(this.y.max)}
    //       L ${this.normaliseX(this.x.max)} ${this.normaliseY(this.y.min)}
    //       L ${this.normaliseX(this.x.min)} ${this.normaliseY(this.y.min)}`

    //   dataset.forEach((point, index) => {
    //     path += ` L ${this.normaliseX(point.x)} ${this.normaliseY(point.y)}`
    //   })

    //   path += 'Z'

    //   return path
    // },

    getPathMiddle (dataset) {
      //used to add circle to a dataset with key used in the legend
      let middle = dataset[Math.floor(dataset.length/2)]

      return { x: this.normaliseX(middle.x), y: this.normaliseY(middle.y) }
    },

    getAxis (axis) {
      let axisTickLabels = [], n = this[axis].min
      const incrementor = (this[axis].max - this[axis].min)/ this[axis].axisMarks

      while( n < this[axis].max + incrementor) {
        axisTickLabels.push({
          coord: this[`normalise${axis.toUpperCase()}`](n),
          labelText: Math.ceil(n/this[axis].precision)*this[axis].precision
        })

        n += incrementor
      }

      return axisTickLabels
    },

    getLineColourPair (line) {
      return line.colour ? line.colour : DEFAULT_LINE_COLOUR
    },

    // getMinMax(type, prop) {
    //   let array = []

    //   this.lines.forEach(line => {
    //     array.push(Math[type](...line.datapoints.map((t) => {
    //       return t[prop]
    //     })))
    //   }) 
    
    //   return Math.max(...array)
    // },

    // normaliseX (value) {
    //   // subtract the min value incase the axis doesn't start at 0
    //   return this.chartWidth * (value - this.x.min) / (this.x.max - this.x.min)
    // },

    // normaliseY (value) {
    //   // y origin is at the top so subtract axis value from height
    //   // subtract the min value incase the axis doesn't start at 0
    //   return this.chartHeight * (1 - (value - this.y.min) / (this.y.max - this.y.min))
    // },
  }
}
</script>