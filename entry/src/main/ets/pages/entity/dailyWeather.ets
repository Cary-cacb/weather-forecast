import { daily } from './daily'
import { refer } from './refer'

export class dailyWeather{
  code:string
  updateTime:string
  fxLink:string
  daily:daily[]
  refer:refer

  constructor(code: string, updateTime: string, fxLink: string, daily: daily[], refer: refer) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.daily = daily
    this.refer = refer
  }

}