import { router } from '@kit.ArkUI'
import { dailyWeather } from '../entity/dailyWeather'

@Component
export struct dailyWeatherViewModel {
  @Link new3DWeather: dailyWeather
  @Link longitude: number
  @Link latitude: number

  build() {
    ListItem() {
      Column() {
        Row() {
          Image($r(`app.media.${this.new3DWeather?.daily[0].iconDay}`))
            .size({ width: 35, height: 35 })
            .margin({ right: 15 })

          Text('今天')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ right: 15 })
          if (this.new3DWeather?.daily[0].textDay != this.new3DWeather?.daily[0].textNight) {
            Text(`${this.new3DWeather?.daily[0].textDay}转${this.new3DWeather?.daily[0].textNight}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          } else {
            Text(`${this.new3DWeather?.daily[0].textDay}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          }
          Text('良')
            .fontSize(15)
            .fontColor(Color.White)
            .size({ height: 25, width: 25 })
            .backgroundColor('rgba(171, 171, 171, 0.68)')
            .borderRadius(10)
            .textAlign(TextAlign.Center)
            .margin({ right: 40 })

          Text(`${this.new3DWeather?.daily[0].tempMax}°/${this.new3DWeather?.daily[0].tempMin}°`)
            .fontSize(20)
            .fontColor(Color.White)
        }.width('97%')
        .height(50)
        .padding({ bottom: 30 })

        Row() {
          Image($r(`app.media.${this.new3DWeather?.daily[1].iconDay}`))
            .size({ width: 35, height: 35 })
            .margin({ right: 15 })

          Text('明天')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ right: 15 })
          if (this.new3DWeather?.daily[1].textDay != this.new3DWeather?.daily[1].textNight) {
            Text(`${this.new3DWeather?.daily[1].textDay}转${this.new3DWeather?.daily[1].textNight}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          } else {
            Text(`${this.new3DWeather?.daily[1].textDay}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          }

          Text('优')
            .fontSize(15)
            .fontColor(Color.White)
            .size({ height: 25, width: 25 })
            .backgroundColor('rgba(171, 171, 171, 0.68)')
            .borderRadius(10)
            .textAlign(TextAlign.Center)
            .margin({ right: 40 })

          Text(`${this.new3DWeather?.daily[1].tempMax}°/${this.new3DWeather?.daily[1].tempMin}°`)
            .fontSize(20)
            .fontColor(Color.White)
        }.width('97%')
        .height(50)
        .padding({ bottom: 30 })


        Row() {
          Image($r(`app.media.${this.new3DWeather?.daily[2].iconDay}`))
            .size({ width: 35, height: 35 })
            .margin({ right: 15 })

          Text('后天')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ right: 15 })
          if (this.new3DWeather?.daily[2].textDay != this.new3DWeather?.daily[2].textNight) {
            Text(`${this.new3DWeather?.daily[2].textDay}转${this.new3DWeather?.daily[2].textNight}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          } else {
            Text(`${this.new3DWeather?.daily[2].textDay}`)
              .fontSize(20)
              .fontColor(Color.White)
              .width(110)
          }
          Text('良')
            .fontSize(15)
            .fontColor(Color.White)
            .size({ height: 25, width: 25 })
            .backgroundColor('rgba(171, 171, 171, 0.68)')
            .borderRadius(10)
            .textAlign(TextAlign.Center)
            .margin({ right: 40 })

          Text(`${this.new3DWeather?.daily[2].tempMax}°/${this.new3DWeather?.daily[2].tempMin}°`)
            .fontSize(20)
            .fontColor(Color.White)
        }.width('97%')
        .height(50)
        .padding({ bottom: 10 })

        Row() {
          Button() {
            Text('查看近十五日天气')
              .fontSize(20)
              .fontColor(Color.White)
          }
          .backgroundColor('rgba(218, 218, 218, 0.5)')
          .width('90%')
          .height(50)
          .borderRadius(30)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/fifteenDaysWeather',
              params: { mainCode: `${this.longitude},${this.latitude}` }
            })
          })
        }.width('97%')
        .height(50)
        .justifyContent(FlexAlign.Center)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }
    .height(250)
    .width('95%')
    .margin({ left: '2.5%', bottom: 10 })
    .borderRadius(20)
    .backgroundColor('rgba(226, 226, 226, 0.3)')
  }
}