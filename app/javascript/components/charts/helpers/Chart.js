export default class ChartDataset {
  constructor({ datasets, chartWidth, chartHeight }) {
    this.datasets = datasets
    this.chartWidth = chartWidth
    this.chartHeight = chartHeight
    this.xMin = this.getMinMax('min', 'x')
    this.xMax = this.getMinMax('max', 'x')
    this.yMin = 0
    this.yMax = this.getMinMax('max', 'y')
  }

  getPath(dataset, fill = false, labelled = false) {
    let path = ''

    if(fill) {
      path += `M ${this.normaliseX(this.xMax)} ${this.normaliseY(this.yMax)}
        L ${this.normaliseX(this.xMax)} ${this.normaliseY(this.yMin)}
        L ${this.normaliseX(this.xMin)} ${this.normaliseY(this.yMin)}`
      
      dataset.forEach((point, index) => {
        path += ` L ${this.normaliseX(point.x)} ${this.normaliseY(point.y)}`
      })

      path += 'Z'

    } else {
      dataset.forEach((point, index) => {
        const command = index == 0 ? 'M' : 'L'

        path += ` ${command} ${this.normaliseX(point.x)} ${this.normaliseY(point.y)}`
      })
    }

    return path
  },

  getMinMax(type, prop) {
    let array = []

    this.datasets.forEach(dataset => {
      array.push(Math[type](...dataset.datapoints.map((t) => {
        return t[prop]
      })))
    }) 
  
    return Math.max(...array)
  },

  normaliseX (value) {
    // subtract the min value incase the axis doesn't start at 0
    return this.chartWidth * (value - this.xMin) / (this.xMax - this.xMin)
  },

  normaliseY (value) {
    // y origin is at the top so subtract axis value from height
    // subtract the min value incase the axis doesn't start at 0
    return this.chartHeight * (1 - (value - this.yMin) / (this.yMax - this.yMin))
  },
}