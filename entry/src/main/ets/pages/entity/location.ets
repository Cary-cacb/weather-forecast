export class location {
  name: string
  id: string
  lat: string
  lon: string
  adm2: string
  adm1: string
  country: string
  tz: string
  utcOffset: string
  isDst: string
  type: string
  rank: string
  fxLink: string

  constructor(name: string, id: string, lat: string, lon: string, adm2: string, adm1: string, country: string,
    tz: string, utcOffset: string, isDst: string, type: string, rank: string, fxLink: string) {
    this.name = name
    this.id = id
    this.lat = lat
    this.lon = lon
    this.adm2 = adm2
    this.adm1 = adm1
    this.country = country
    this.tz = tz
    this.utcOffset = utcOffset
    this.isDst = isDst
    this.type = type
    this.rank = rank
    this.fxLink = fxLink
  }


}