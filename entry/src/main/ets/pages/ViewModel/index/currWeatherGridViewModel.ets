import { CurrWeather } from '../../entity/currWeather'
import { dailyWeather } from '../../entity/dailyWeather'

@Component
export struct currWeatherGridViewModel {
  @Link currWeather: CurrWeather
  @Link new3DWeather: dailyWeather

  build() {
    ListItem() {
      Row({ space: 10 }) {
        Column({ space: 10 }) {
          //风力风向
          Column({ space: 20 }) {
            Text(this.currWeather?.now.windDir)
              .fontColor(Color.White)
              .fontSize(40)
            Text(`${this.currWeather?.now.windScale}级`)
              .fontColor(Color.White)
              .fontSize(35)
          }
          .height('50%')
          .width('100%')
          .backgroundColor('rgba(226, 226, 226, 0.3)')
          .borderRadius(20)
          .justifyContent(FlexAlign.Center)

          //日出日落时间
          Column() {
            Row() {
              Text(this.new3DWeather?.daily[0].sunrise)
                .fontColor(Color.White)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
              Text('日出')
                .fontColor(Color.White)
                .fontSize(25)
                .fontWeight(FontWeight.Normal)
            }
            .height('50%')
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Bottom)
            .margin({ bottom: 15 })


            Row() {
              Text(this.new3DWeather?.daily[0].sunset)
                .fontColor(Color.White)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
              Text('日落')
                .fontColor(Color.White)
                .fontSize(25)
                .fontWeight(FontWeight.Normal)
            }.height('50%')
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Top)

          }.height('46.7%')
          .width('100%')
          .backgroundColor('rgba(226, 226, 226, 0.3)')
          .borderRadius(20)

        }.height('100%')
        .width('50%')

        Column() {
          //湿度
          Row() {
            Text('湿度')
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Normal)

            Text(`${this.currWeather?.now.humidity}%`)
              .fontColor(Color.White)
              .fontSize(25)
              .fontWeight(FontWeight.Medium)
          }
          .height(60)
          .width('80%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Bottom)
          .padding({ bottom: 5 })

          Divider()
            .color('rgba(255, 255, 255, 0.55)')
            .strokeWidth(1)
            .width('80%')

          //体感温度
          Row() {
            Text('体感')
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Normal)

            Text(`${this.currWeather?.now.feelsLike}°`)
              .fontColor(Color.White)
              .fontSize(25)
              .fontWeight(FontWeight.Medium)
          }
          .height(60)
          .width('80%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Bottom)
          .padding({ bottom: 5 })

          Divider()
            .color('rgba(255, 255, 255, 0.55)')
            .strokeWidth(1)
            .width('80%')

          //能见度
          Row() {
            Text('能见度')
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Normal)

            Text(this.currWeather?.now.vis)
              .fontColor(Color.White)
              .fontSize(25)
              .fontWeight(FontWeight.Medium)
          }
          .height(60)
          .width('80%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Bottom)
          .padding({ bottom: 5 })

          Divider()
            .color('rgba(255, 255, 255, 0.55)')
            .strokeWidth(1)
            .width('80%')

          //气压
          Row() {
            Text('气压')
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Normal)

            Text(this.currWeather?.now.pressure)
              .fontColor(Color.White)
              .fontSize(25)
              .fontWeight(FontWeight.Medium)
          }
          .height(60)
          .width('80%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Bottom)
          .padding({ bottom: 5 })

          Divider()
            .color('rgba(255, 255, 255, 0.55)')
            .strokeWidth(1)
            .width('80%')
        }
        .height('100%')
        .width('46.9%')
        .backgroundColor('rgba(226, 226, 226, 0.3)')
        .borderRadius(20)
        .justifyContent(FlexAlign.Start)
      }.height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .height(300)
    .width('95%')
    .margin({ left: '2.5%', bottom: 10 })
    .borderRadius(20)
  }
}