import { dailyPoint } from './daliyPoint'
import { refer } from './refer'

export class weatherPoints {
  code: string
  updateTime: string
  fxLink: string
  daily: dailyPoint[]
  refer: refer

  constructor(code: string, updateTime: string, fxLink: string, daily: dailyPoint[], refer: refer) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.daily = daily
    this.refer = refer
  }
}