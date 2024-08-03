import weatherModel from './ViewModel/HTTPModel'

import { dailyWeather } from './entity/dailyWeather'
import { router } from '@kit.ArkUI'
import { daily } from './entity/daily'
import { JSON } from '@kit.ArkTS'


class routerParams {
  mainCode: string

  constructor(mainCode: string) {
    this.mainCode = mainCode
  }
}

@Entry
@Component
struct fifteenDaysWeather {
  private settings_1: RenderingContextSettings = new RenderingContextSettings(true);
  private context_1: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings_1);
  private settings_2: RenderingContextSettings = new RenderingContextSettings(true);
  private context_2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings_2);

  aboutToAppear(): void {

  }

  @State dailyWeather: dailyWeather | undefined = undefined
  @State heiWea: number[] = []
  @State lowWea: number[] = []
  @State maxT_H: number = 0
  @State minT_H: number = 0
  @State maxT_L: number = 0
  @State minT_L: number = 0
  @State i: number = 0
  @State mainCode: string = (router.getParams() as routerParams).mainCode

  build() {
    Column() {
      //返回按钮
      Row() {
        Button() {
          Image($r('app.media.back'))
        }.size({ width: 30, height: 30 })
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          router.back()
        })
      }.width('100%')
      .height(30)
      .margin({ bottom: 5, top: 10, left: 10 })

      //表头
      Row() {

        Text('15日天气趋势预报')
          .fontSize(40)
          .fontColor('#686868')
          .margin({ left: 15 })

      }
      .width('100%')
      .height(90)

      Scroll() {
        Column() {
          //白天
          Column() {
            Row() {
              ForEach(this.dailyWeather?.daily, (item: daily, index) => {
                Column({ space: 10 }) {
                  Text(`${item.fxDate.split('-')[1]}月${item.fxDate.split('-')[2]}日`)
                    .fontSize(15)
                    .fontColor(Color.Black)
                  Image($r(`app.media.${item.iconDay}`))
                    .size({ width: 25, height: 25 })


                  Text(item.textDay)
                    .fontSize(15)
                    .fontColor(Color.Black)


                }.position({ x: 10 + 80 * index })
                .justifyContent(FlexAlign.Center)

              })
            }

            .height(80)


            Canvas(this.context_1)
              .height(110)

              .width(1200)
              .onReady(() => {
                let location: string = (router.getParams() as routerParams).mainCode
                weatherModel.get15DayWeatherListByHttp(location)
                  .then(dailyWeather => {
                    this.dailyWeather = dailyWeather
                    console.log('15日天气' + location)
                    console.log('15日天气' + dailyWeather)
                    console.log('15日天气' + this.dailyWeather)
                    console.log('15日天气' + JSON.stringify(this.dailyWeather))
                    this.maxT_H = Number(this.dailyWeather?.daily[0].tempMax)
                    this.minT_H = Number(this.dailyWeather?.daily[0].tempMax)
                    this.dailyWeather?.daily.forEach(daily => {
                      console.log('15日天气每次获取数据' + JSON.stringify(daily))
                      this.heiWea.push(Number(daily.tempMax))
                      if (Number(daily.tempMax) > this.maxT_H) {
                        this.maxT_H = Number(daily.tempMax)
                      }
                      if (Number(daily.tempMax) < this.minT_H) {
                        this.minT_H = Number(daily.tempMax)
                      }


                    })
                    console.log('15日天气上下限' + this.maxT_L + '/' + this.maxT_H + '/' + this.minT_H + '/' +
                    this.minT_L)
                    this.context_1.beginPath()
                    this.context_1.lineWidth = 3
                    this.context_1.fillStyle = Color.Black
                    this.context_1.strokeStyle = 'rgba(104, 104, 104, 0.5)'
                    this.context_1.font = '20vp sans-serif'
                    this.context_1.moveTo(37,
                      35 + (1 - (this.heiWea[0] - this.minT_H) / (this.maxT_H - this.minT_H)) * 70)

                    for (this.i = 0; this.i < 15; this.i++) {
                      this.context_1.fillText(`${this.heiWea[this.i]}°`, 25 + 80 * this.i,
                        20 + (1 - (this.heiWea[this.i] - this.minT_H) / (this.maxT_H - this.minT_H)) * 70)
                      this.context_1.lineTo(37 + 80 * this.i,
                        35 + (1 - (this.heiWea[this.i] - this.minT_H) / (this.maxT_H - this.minT_H)) * 70)
                      this.context_1.arc(37 + 80 * this.i,
                        35 + (1 - (this.heiWea[this.i] - this.minT_H) / (this.maxT_H - this.minT_H)) * 70, 3, 0, 6.28)

                    }
                    this.context_1.stroke()
                  })

              })


          }.height('50%')
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.End)

          //晚上
          Column() {

            Canvas(this.context_2)
              .height(110)

              .width(1200)
              .onReady(() => {
                let location: string = (router.getParams() as routerParams).mainCode
                weatherModel.get15DayWeatherListByHttp(location)
                  .then(dailyWeather => {
                    this.maxT_L = Number(dailyWeather.daily[0].tempMin)
                    this.minT_L = Number(dailyWeather.daily[0].tempMin)
                    dailyWeather.daily.forEach(daily => {
                      this.lowWea.push(Number(daily.tempMin))

                      if (Number(daily.tempMin) > this.maxT_L) {
                        this.maxT_L = Number(daily.tempMax)
                      }
                      if (Number(daily.tempMin) < this.minT_L) {
                        this.minT_L = Number(daily.tempMin)
                      }
                    })
                    this.context_2.beginPath()
                    this.context_2.lineWidth = 3
                    this.context_2.fillStyle = Color.Black
                    this.context_2.strokeStyle = 'rgba(104, 104, 104, 0.5)'
                    this.context_2.font = '20vp sans-serif'
                    this.context_2.fillText(`${this.lowWea[0]}°`, 25,
                      20 + (1 - (this.lowWea[0] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70)
                    this.context_2.moveTo(37,
                      35 + (1 - (this.lowWea[0] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70)
                    this.context_2.arc(37,
                      35 + (1 - (this.lowWea[0] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70, 3, 0, 6.28)

                    for (this.i = 1; this.i < 15; this.i++) {
                      this.context_2.fillText(`${this.lowWea[this.i]}°`, 25 + 80 * this.i,
                        20 + (1 - (this.lowWea[this.i] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70)

                      this.context_2.lineTo(37 + 80 * this.i,
                        35 + (1 - (this.lowWea[this.i] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70)
                      this.context_2.arc(37 + 80 * this.i,
                        35 + (1 - (this.lowWea[this.i] - this.minT_L) / (this.maxT_L - this.minT_L)) * 70, 3, 0, 6.28)

                    }
                    this.context_2.stroke()

                  })


              })
            Row() {
              ForEach(this.dailyWeather?.daily, (item: daily, index) => {
                Column({ space: 10 }) {
                  Image($r(`app.media.${item.iconNight}`))
                    .size({ width: 25, height: 25 })


                  Text(item.textNight)
                    .fontSize(15)
                    .fontColor(Color.Black)
                  Text(`${item.windScaleDay.split('-')[1]}级`)
                    .fontSize(15)
                    .fontColor(Color.Black)
                    .size({ width: 25, height: 25 })


                }.position({ x: 23 + 80 * index })
                .justifyContent(FlexAlign.Center)

              })
            }
            .height(80)

          }.height('50%')
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
        }.height('100%')
        .justifyContent(FlexAlign.Start)

      }.height(500)
      .scrollable(ScrollDirection.Horizontal)

    }.width('100%')
    .height('100% ')
    .justifyContent(FlexAlign.Start)
  }
}