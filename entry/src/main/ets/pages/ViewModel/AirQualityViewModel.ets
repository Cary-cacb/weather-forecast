import { weatherPoints } from '../entity/weatherPoints'
import weatherModel from '../Model/HTTPModel'
@Component
export struct airQuality {
  @State clothStr: string = ''
  @State SunStr: string = ''
  @State sportStr: string = ''
  @State weatherPoints: weatherPoints | undefined = undefined
  @Link longitude: number
  @Link latitude: number

  aboutToAppear(): void {
    weatherModel.getWeatherPointsByHttp(`${this.longitude},${this.latitude}`)
      .then(weatherPoints => {
        this.weatherPoints = weatherPoints
        switch (Number(this.weatherPoints.daily[0].level)) {
          case (1):
            this.sportStr = '适宜户外运动'
          case (2):
            this.sportStr = '较适宜'
          case (3):
            this.sportStr = '适宜室内运动'
        }
        switch (Number(this.weatherPoints.daily[2].level)) {
          case 1:
            this.clothStr = '注意防寒';
            break
          case 2:
            this.clothStr = '注意保暖';
            break
          case 3:
            this.clothStr = '适当加衣';
            break
          case 4:
            this.clothStr = '适宜长袖';
            break
          case 5:
            this.clothStr = '适宜短袖';
            break
          case 6:
            this.clothStr = '适宜短袖';
            break
          case 7:
            this.clothStr = '适宜短袖';
            break
        }

        switch (Number(this.weatherPoints.daily[15].level)) {
          case 1:
            this.SunStr = '无需防晒';
            break
          case 2:
            this.SunStr = '无需防晒';
            break
          case 3:
            this.SunStr = '不是很晒';
            break
          case 4:
            this.SunStr = '注意防晒';
            break
          case 5:
            this.SunStr = '注意防晒';
            break
        }
      }
      )}

  build() {
    ListItem() {
      Grid() {
        GridItem() {
          //穿衣指数
          Column({ space: 15 }) {
            Image($r('app.media.cloth'))
              .size({ width: 60, height: 60 })

            Text(this.clothStr)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')

        //防晒指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.sunshine'))
              .size({ width: 60, height: 60 })

            Text(this.SunStr)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')

        //运动指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.sports'))
              .size({ width: 60, height: 60 })

            Text(this.sportStr)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')

        //洗车指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.car'))
              .size({ width: 60, height: 60 })

            Text(this.weatherPoints?.daily[1].category + '洗车')
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')

        //钓鱼指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.fishing'))
              .size({ width: 60, height: 60 })

            Text(this.weatherPoints?.daily[3].category + '钓鱼')
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')

        //感冒指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.jiaonang'))
              .size({ width: 60, height: 60 })

            Text(this.weatherPoints?.daily[8].category + '感冒')
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

        }
        .backgroundColor('rgba(226, 226, 226, 0.3)')

      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr ')
      .rowsGap(1)
      .columnsGap(1)
      .borderRadius(20)
      .width('100%')
      .height(('100%'))

    }.height(300)
    .width('95%')
    .margin({ left: '2.5%', bottom: 50 })
  }
}