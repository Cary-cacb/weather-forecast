import { minutely } from './minutely'
import { refer } from './refer'

export class fiveMinutesRain {
  code: string
  updateTime: string
  fxLink: string
  summary: string
  minutely: minutely[]
  refer: refer

  constructor(code: string, updateTime: string, fxLink: string, summary: string, minutely: minutely[], refer: refer) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.summary = summary
    this.minutely = minutely
    this.refer = refer
  }
}