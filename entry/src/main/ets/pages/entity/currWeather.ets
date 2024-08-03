import { now } from './now'
import { refer } from './refer'

export class CurrWeather {
  code: string
  updateTime: string
  fxLink: string
  now: now
  refer: refer


  constructor(code: string, updateTime: string, fxLink: string, now: now, refer: refer) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.now = now
    this.refer = refer
  }

}