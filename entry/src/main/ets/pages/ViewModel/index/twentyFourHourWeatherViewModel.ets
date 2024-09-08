import { geoLocationManager } from '@kit.LocationKit'
import { twentyFourHourWeather } from '../../entity/twentyFourHourWeather'
import weatherModel from '../../Model/HTTPModel'
import { BusinessError } from '@kit.BasicServicesKit'
import { hourly } from '../../entity/hourly'

@Component
export struct twentyFourHourWeatherViewModel {
  private settings_2: RenderingContextSettings = new RenderingContextSettings(true);
  private context_2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings_2);
  @State twentyFourHourWeatherList: twentyFourHourWeather | undefined = undefined

  build() {
    ListItem() {
      Column() {
        Row() {
          Image($r('app.media.clock'))
            .size({ width: 20, height: 20 })
            .fillColor('rgba(198, 198, 198, 0.8)')
            .margin({ left: 12 })

          Text('24小时预报')
            .fontSize(20)
            .fontColor('rgba(198, 198, 198, 0.8)')
            .margin({ left: 15 })
        }
        .width('100%')
        .height(35)

        Scroll() {
          Column() {
            Canvas(this.context_2)
              .height(90)
              .width(1440)
              .onReady(() => {
                let requestInfo: geoLocationManager.CurrentLocationRequest = {
                  'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX,
                  'scenario': geoLocationManager.LocationRequestScenario.UNSET,
                  'maxAccuracy': 0
                };
                geoLocationManager.getCurrentLocation(requestInfo).then((result_) => {
                  console.log('current location: ' + JSON.stringify(result_));
                  let local_ = `${result_.longitude},${result_.latitude}`
                  weatherModel.get24HourWeatherListByHttp(local_)
                    .then((wl) => {
                      this.twentyFourHourWeatherList = wl
                      let hourlyList = wl.hourly
                      let tempList: number[] = []
                      hourlyList.forEach((item) => {
                        tempList.push(Number(item.temp))
                      })
                      let maxT = tempList[0]
                      let minT = tempList[0]
                      tempList.forEach((item) => {
                        if (item > maxT) {
                          maxT = item
                        }
                        if (item < minT) {
                          minT = item
                        }
                      })
                      this.context_2.beginPath()
                      this.context_2.lineWidth = 5
                      this.context_2.fillStyle = Color.White
                      this.context_2.font = '20vp sans-serif'
                      this.context_2.strokeStyle = Color.Yellow
                      this.context_2.fillText(`${tempList[0]}°`, 15,
                        20 + (1 - (tempList[0] - minT) / (maxT - minT)) * 55)
                      this.context_2.moveTo(25,
                        30 + (1 - (tempList[0] - minT) / (maxT - minT)) * 55)
                      for (let i = 1; i < 24; i++) {

                        this.context_2.fillText(`${tempList[i]}°`, 15 + 60 * i,
                          20 +
                            (1 - (tempList[i] - minT) / (maxT - minT)) * 55)

                        this.context_2.lineTo(25 + 60 * i,
                          30 +
                            (1 - (tempList[i] - minT) / (maxT - minT)) * 55)
                      }
                      this.context_2.stroke()
                    })
                })
                  .catch((error: BusinessError) => {
                    console.error('promise, getCurrentLocation: error=' + JSON.stringify(error));
                  });
              })
            Row() {
              ForEach(this.twentyFourHourWeatherList?.hourly, (item: hourly, index) => {
                Column({ space: 10 }) {
                  Image($r(`app.media.${item.icon}`))
                    .size({ width: 35, height: 35 })

                  Text(`${item.windScale[2]}级`)
                    .fontSize(15)
                    .fontColor(Color.White)

                  Text('优')
                    .fontSize(17)
                    .fontColor(Color.White)
                    .size({ width: 25, height: 25 })
                    .backgroundColor('rgba(171, 171, 171, 0.68)')
                    .borderRadius(5)
                    .textAlign(TextAlign.Center)

                  Text((item.fxTime.split('T')[1]).split('+')[0])
                    .fontSize(15)
                    .fontColor(Color.White)
                }.position({ x: 10 + 60 * index })
                .justifyContent(FlexAlign.Center)
              })
            }
            .margin({ top: 10 })
            .height(125)
          }.height(235)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
        }.height(235)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBarColor(Color.Transparent)
      }.width('100%')
      .height('100% ')
      .justifyContent(FlexAlign.Start)
    }
    .height(270)
    .width('95%')
    .margin({ left: '2.5%', bottom: 10 })
    .borderRadius(20)
    .backgroundColor('rgba(226, 226, 226, 0.3)') //'rgba(83, 83, 83, 0.6)'
  }
}