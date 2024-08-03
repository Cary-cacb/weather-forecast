import { hourly } from './hourly'
import { refer } from './refer'

export class twentyFourHourWeather{
  code:string
  updateTime:string
  fxLink:string
  hourly:hourly[]
  refer:refer

  constructor(code: string, updateTime: string, fxLink: string, hourly: hourly[], refer: refer) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.hourly = hourly
    this.refer = refer
  }

}