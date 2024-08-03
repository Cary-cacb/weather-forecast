import { health } from './health'
import { primaryPollutant } from './primaryPollutant'

export class aqi {
  code: string
  name: string
  defaultLocalAqi: boolean
  value: number
  valueDisplay: string
  level: string
  category: string
  color: string
  primaryPollutant: primaryPollutant
  health: health

  constructor(code: string, name: string, defaultLocalAqi: boolean, value: number, valueDisplay: string, level: string,
    category: string, color: string, primaryPollutant: primaryPollutant, health: health) {
    this.code = code
    this.name = name
    this.defaultLocalAqi = defaultLocalAqi
    this.value = value
    this.valueDisplay = valueDisplay
    this.level = level
    this.category = category
    this.color = color
    this.primaryPollutant = primaryPollutant
    this.health = health
  }
}