import { aqi } from './aqi'
import { pollutant } from './pollutant'
import { station } from './station'

export class airQuality {
  code: string
  updateTime: string
  aqi: aqi[]
  pollutant: pollutant
  station: station
  source: string

  constructor(code: string, updateTime: string, aqi: aqi[], pollutant: pollutant, station: station, source: string) {
    this.code = code
    this.updateTime = updateTime
    this.aqi = aqi
    this.pollutant = pollutant
    this.station = station
    this.source = source
  }
}