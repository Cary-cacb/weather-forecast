export class daily {
  fxDate: string
  sunrise: string
  sunset: string
  moonrise: string
  moonset: string
  moonPhase: string
  moonPhaseIcon: string
  tempMax: string
  tempMin: string
  iconDay: string
  textDay: string
  iconNight: string
  textNight: string
  wind360Day: string
  windDirDay: string
  windScaleDay: string
  windSpeedDay: string
  wind360Night: string
  windDirNight: string
  windScaleNight: string
  windSpeedNight: string
  precip: string
  uvIndex: string
  humidity: string
  pressure: string
  vis: string
  cloud: string

  constructor(fxDate: string, sunrise: string, sunset: string, moonrise: string, moonset: string, moonPhase: string,
    moonPhaseIcon: string, tempMax: string, tempMin: string, iconDay: string, textDay: string, iconNight: string,
    textNight: string, wind360Day: string, windDirDay: string, windScaleDay: string, windSpeedDay: string,
    wind360Night: string, windDirNight: string, windScaleNight: string, windSpeedNight: string, precip: string,
    uvIndex: string, humidity: string, pressure: string, vis: string, cloud: string, sources: string, license: string) {
    this.fxDate = fxDate
    this.sunrise = sunrise
    this.sunset = sunset
    this.moonrise = moonrise
    this.moonset = moonset
    this.moonPhase = moonPhase
    this.moonPhaseIcon = moonPhaseIcon
    this.tempMax = tempMax
    this.tempMin = tempMin
    this.iconDay = iconDay
    this.textDay = textDay
    this.iconNight = iconNight
    this.textNight = textNight
    this.wind360Day = wind360Day
    this.windDirDay = windDirDay
    this.windScaleDay = windScaleDay
    this.windSpeedDay = windSpeedDay
    this.wind360Night = wind360Night
    this.windDirNight = windDirNight
    this.windScaleNight = windScaleNight
    this.windSpeedNight = windSpeedNight
    this.precip = precip
    this.uvIndex = uvIndex
    this.humidity = humidity
    this.pressure = pressure
    this.vis = vis
    this.cloud = cloud
  }
}