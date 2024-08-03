export class now {
  obsTime: string
  temp: string
  feelsLike: string
  icon: string
  text: string
  wind360: string
  windDir: string
  windScale: string
  windSpeed: string
  humidity: string
  precip: string
  pressure: string
  vis: string
  cloud: string
  dew: string


  constructor(obsTime: string, temp: string, feelsLike: string, icon: string, text: string, wind360: string,
    windDir: string, windScale: string, windSpeed: string, humidity: string, precip: string, pressure: string,
    vis: string, cloud: string, dew: string) {
    this.obsTime = obsTime
    this.temp = temp
    this.feelsLike = feelsLike
    this.icon = icon
    this.text = text
    this.wind360 = wind360
    this.windDir = windDir
    this.windScale = windScale
    this.windSpeed = windSpeed
    this.humidity = humidity
    this.precip = precip
    this.pressure = pressure
    this.vis = vis
    this.cloud = cloud
    this.dew = dew

  }

}