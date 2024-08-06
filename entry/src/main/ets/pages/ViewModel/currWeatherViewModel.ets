import { CurrWeather } from '../entity/currWeather'

@Component
export struct currWeatherViewModel{
  @Link currWeather:CurrWeather
  @Link nowWea:string
  @Link maxTem:string
  @Link minTem:string
  @Link clear:string
  @Link airQuality:number
  @Link isRain:string
  build() {
    ListItem() {
      Column() {
        Row({ space: 20 }) {
          Text(this.currWeather?.now.temp)
            .fontSize(100)
            .fontColor(Color.White)
          Text('℃')
            .fontSize(40)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 60 })
        }.height(200)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Bottom)

        Row({ space: 20 }) {
          Text(this.nowWea)
            .fontSize(35)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
          Text(`${this.maxTem}°/${this.minTem}°`)
            .fontSize(35)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)

        }.height(40)
        .width('60%')
        .justifyContent(FlexAlign.Center)

        Row({ space: 30 }) {
          Text(this.clear + ' ' + this.airQuality)
            .fontColor(Color.White)
            .fontSize(20)
            .backgroundColor('rgba(180, 180, 180, 0.2)')
            .height(35)
            .borderRadius(20)
            .width((this.clear.length) * 20 + 60)
            .textAlign(TextAlign.Center)

          Text(this.isRain)
            .fontColor(Color.White)
            .fontSize(20)
            .height(35)
            .borderRadius(20)
            .width(this.isRain.length * 20 + 40)
            .backgroundColor('rgba(180, 180, 180, 0.2)')
            .textAlign(TextAlign.Center)
        }
        .height(60)
        .alignItems(VerticalAlign.Bottom)
      }
    }.height(400)
    .padding({ bottom: 100 })
  }
}