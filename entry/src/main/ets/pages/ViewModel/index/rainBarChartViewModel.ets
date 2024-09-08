import { geoLocationManager } from '@kit.LocationKit';
import weatherModel from '../../Model/HTTPModel';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct rainBarChartViewModel {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @State rainToStop: string = ''

  build() {
    ListItem() {
      Column() {
        Row() {
          Text(this.rainToStop)
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Normal)
        }
        .width('100%')
        .height(40)
        // .backgroundColor(Color.Blue)
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Center)

        Canvas(this.context) {
        }
        .width('100%')
        .height(120)
        .onReady(() => {
          let requestInfo: geoLocationManager.CurrentLocationRequest = {
            'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX,
            'scenario': geoLocationManager.LocationRequestScenario.UNSET,
            'maxAccuracy': 0
          };
          geoLocationManager.getCurrentLocation(requestInfo).then((result) => {
            console.log('current location: ' + JSON.stringify(result));
            weatherModel.getMinutelyRainListByHttp(`${result.longitude},${result.latitude}`)
              .then(val => {
                this.rainToStop = val.summary
                let rainList: number[] = []
                val.minutely.forEach((val) => {
                  rainList.push(Number(val.precip))
                  this.context.beginPath()
                  this.context.fillStyle = Color.White
                  this.context.font = '15vp sans-serif'
                  this.context.fillText('大', 8, 25)
                  this.context.fillText('中', 8, 65)
                  this.context.fillText('小', 8, 105)
                  this.context.lineWidth = 1
                  this.context.lineJoin = 'miter'
                  this.context.strokeStyle = 'rgba(157, 157, 157, 0.61)'
                  this.context.setLineDash([2, 2])
                  this.context.moveTo(0, 35)
                  this.context.lineTo(500, 35)
                  this.context.moveTo(0, 75)
                  this.context.lineTo(500, 75)
                  this.context.moveTo(0, 115)
                  this.context.lineTo(500, 115)
                  this.context.stroke()
                  this.context.beginPath()
                  this.context.lineWidth = 10
                  this.context.setLineDash([0, 0])
                  this.context.strokeStyle = "rgba(171, 171, 171, 0.68)"
                  for (let i = 0; i < 24; i++) {
                    this.context.moveTo(35 + i * 13, 112)
                    this.context.lineTo(35 + i * 13, 112 - 92 * rainList[i])
                    this.context.stroke()
                  }
                })
              })
          })
            .catch((error: BusinessError) => {
              console.error('promise, getCurrentLocation: error=' + JSON.stringify(error));
            });
        })

        Row() {
          Text('现在')
            .fontSize(16)
            .fontColor(Color.White)

          Text('1小时后')
            .fontSize(16)
            .fontColor(Color.White)

          Text('2小时后')
            .fontSize(16)
            .fontColor(Color.White)
        }.width('100%')
        .height(35)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Top)
      }
      .backgroundColor('rgba(226, 226, 226, 0.2)') //
      .borderRadius(20)
      .height(200)
      .width('100%')
    }
    .height(200)
    .width('97%')
    .padding({ left: '3%' })
    .margin({ bottom: 10 })
  }
}