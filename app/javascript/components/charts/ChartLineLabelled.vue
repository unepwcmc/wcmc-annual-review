<template>
  <div class="chart--line">
    <div class="svg-wrapper-ie11">
      <div class="chart__scrollable">
        <div v-if="lines" class="chart__chart" style="width:100%;">
          <svg width="100%" height="100%" :viewBox="`-${chartPaddingSides} -${svgPaddingTop} ${config.width} ${config.height}`" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" class="chart__svg" :fill="svgBackgroundColour">
            <rect 
              :x="-chartPaddingSides"
              :y="-chartPaddingTop" 
              :rx="20"
              :width="config.width" 
              :height="backgroundHeight" 
              :fill="chartBackgroundColour" />

            <text v-if="axisLabels" :x="-chartPaddingSides" :y="-4.5 * fontSize" :font-size="fontSize">
              <tspan v-for="t in axisLabels.y" :x="-chartPaddingSides" :dy="1.25 * fontSize">{{ t }}</tspan>
            </text>
            
            <template v-if="yAxisConfig.showAxis">
              <text v-for="y in yAxis" 
                :x="-chartPaddingLeft" 
                :y="y.coord"
                text-anchor="end"
                :font-size="fontSize"
                fill="white">{{ y.labelText }}</text>
            </template>
            
            <template v-if="xAxisConfig.showAxis">
              <text v-for="x in xAxis" 
                :x="x.coord" 
                :y="xAxisYDisplacement" 
                :font-size="fontSize"
                text-anchor="middle"
                fill="white">{{ x.labelText }}</text>
            </template>

            <chart-line-dataset 
              v-for="line, index in lines"
              :index="index"
              :path="getPath(line.datapoints)"
              :labels="getDatapointLabels(line.datapoints)"
              :colour="getLineColours(line)">
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
import ChartAxis from './helpers/ChartAxis.js'
import { DEFAULT_COLOUR } from './helpers/chart-constants.js'
import { DEFAULT_SVG_CONFIG } from './helpers/chart-constants.js'

const AXIS_PADDING = 30
const DEFAULT_BACKGROUND_COLOUR = 'transparent'
const DEFAULT_CHART_PADDING_SIDES = 80
const DEFAULT_FONT_SIZE = 14


export default {
  name: 'chart-line-labelled',

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
    options: {
      type: Object,
      default: () => { return { ...DEFAULT_SVG_CONFIG }}
    },
    chartPaddingSides: {
      type: Number,
      default: DEFAULT_CHART_PADDING_SIDES
    }
  }, 

  data () {
    return {
      x: {},
      y: {}
    }
  },

  computed: {
    xAxisConfig () { return {...DEFAULT_SVG_CONFIG.x, ...this.config.x }},
    yAxisConfig () { return {...DEFAULT_SVG_CONFIG.y, ...this.config.y }},

    xAxis () { return new ChartAxis('x', this.x.min, this.x.max, this.xAxisConfig, this.chartWidth).createAxis() },
    yAxis () { return new ChartAxis('y', this.y.min, this.y.max, this.yAxisConfig, this.chartHeight).createAxis() },

    config () { return {...DEFAULT_SVG_CONFIG, ...this.options}},

    svgBackgroundColour () { return this.config.svgBackgroundColour },
    chartBackgroundColour () { return this.config.chartBackgroundColour },

    backgroundHeight () { return this.config.height },

    chartHeight () { return this.backgroundHeight - this.chartPaddingTop - this.fontSize - this.chartPaddingBottom - this.xAxisConfig.offset },

    chartWidth () { return this.config.width - 2 * this.chartPaddingSides },

    chartPaddingLeft () { return AXIS_PADDING },

    svgPaddingTop () { return this.config.svgPaddingTop },
    chartPaddingTop () { return this.config.chartPaddingTop },
    chartPaddingBottom () { return this.config.chartPaddingBottom },

    xAxisYDisplacement () { return this.chartHeight + this.xAxisConfig.offset },

    legendDatasets () {
      const legendDatasets = []

      if (this.lines.length) {
        this.lines.forEach(line => {
          const legendDataset = {
            ...line,
            colour: this.getLineColours(line).line
          }

          legendDatasets.push(legendDataset)
        })
      }

      return legendDatasets
    }
  },

  created () {
    this.x.min = this.getMinMax('min', 'x')
    this.x.max = this.getMinMax('max', 'x')
    this.y.min = 0
    this.y.max = this.getMinMax('max', 'y')
  },

  methods: {
    getPath(dataset) {
      let path = ''
      
      dataset.forEach((point, index) => {
        const command = index == 0 ? 'M' : 'L'

        path += ` ${command} ${this.normaliseX(point.x)} ${this.normaliseY(point.y)}`
      })

      return path
    },

    getPathMiddle (dataset) {
      //used to add circle to a dataset with key used in the legend
      let middle = dataset[Math.floor(dataset.length/2)]

      return { x: this.normaliseX(middle.x), y: this.normaliseY(middle.y) }
    },

    getDatapointLabels (datapoints) {
      let labels = []

      datapoints.forEach((point, index) => {
        labels.push({ 
          x: this.normaliseX(point.x), 
          y: this.normaliseY(point.y),
          value: point.y
        })
      })

      return labels
    },
    
    getLineColours (line) {
      let lineColours = line

      if(lineColours.colour) {
        if(!lineColours.colour.line) { lineColours.colour.line = DEFAULT_COLOUR.line }
        if(!lineColours.colour.fill) { lineColours.colour.fill = DEFAULT_COLOUR.fill }
        if(!lineColours.colour.text) { lineColours.colour.text = DEFAULT_COLOUR.text }
      } else {
        lineColours.colour = { line: DEFAULT_COLOUR.line, fill: DEFAULT_COLOUR.fill, text: DEFAULT_COLOUR.text }
      }

      return lineColours.colour
    },

    getMinMax(type, prop) {
      let array = []

      this.lines.forEach(line => {
        array.push(Math[type](...line.datapoints.map((t) => {
          return t[prop]
        })))
      }) 
    
      return Math.max(...array)
    },

    normaliseX (value) {
      // subtract the min value incase the axis doesn't start at 0
      return this.chartWidth * (value - this.x.min) / (this.x.max - this.x.min)
    },

    normaliseY (value) {
      // y origin is at the top so subtract axis value from height
      // subtract the min value incase the axis doesn't start at 0
      return this.chartHeight * (1 - (value - this.y.min) / (this.y.max - this.y.min))
    },
  }
}
</script>