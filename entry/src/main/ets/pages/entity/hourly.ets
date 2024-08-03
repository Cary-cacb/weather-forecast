export class hourly {
  fxTime:string
  temp:string
  icon:string
  text:string
  wind360:string
  windDir:string
  windScale:string
  windSpeed:string
  humidity:string
  precip:string
  pop:string
  cloud:string
  dew:string

  constructor(fxTime: string, temp: string, icon: string, text: string, wind360: string, windDir: string,
    windScale: string, windSpeed: string, humidity: string, precip: string, pop: string, cloud: string, dew: string) {
    this.fxTime = fxTime
    this.temp = temp
    this.icon = icon
    this.text = text
    this.wind360 = wind360
    this.windDir = windDir
    this.windScale = windScale
    this.windSpeed = windSpeed
    this.humidity = humidity
    this.precip = precip
    this.pop = pop
    this.cloud = cloud
    this.dew = dew
  }

}