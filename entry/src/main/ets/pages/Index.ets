import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';
import weatherModel from './ViewModel/HTTPModel'
import { CurrWeather } from './entity/currWeather'
import { dailyWeather } from './entity/dailyWeather';
import regExpUtil from './RegExpUtil'
import { twentyFourHourWeather } from './entity/twentyFourHourWeather';
import { hourly } from './entity/hourly';
import { weatherPoints } from './entity/weatherPoints';
import router from '@ohos.router';

const permissions: Array<Permissions> = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'];

// 使用UIExtensionAbility：将common.UIAbilityContext 替换为common.UIExtensionContext
function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): void {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
  atManager.requestPermissionsFromUser(context, permissions).then((data) => {
    let grantStatus: Array<number> = data.authResults;
    let length: number = grantStatus.length;
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // 用户授权，可以继续访问目标操作
      } else {
        // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
        return;
      }
    }
    // 授权成功
  }).catch((err: BusinessError) => {
    console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
  })
}

@Entry
@Component
struct Index {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private settings_2: RenderingContextSettings = new RenderingContextSettings(true);
  private context_2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings_2);
  private i: number = 1
  @State fiveMinutesRainList: number[] = []
  @State result: geoLocationManager.Location | undefined = undefined;
  @State latitude: number = 0
  @State longitude: number = 0
  @State locationNum: string = ''
  @State currWeather: CurrWeather | undefined = undefined
  @State new3DWeather: dailyWeather | undefined = undefined
  @State title: string = ''
  @State clear: string = ''
  @State rainToStop: string = ''
  @State nowTem: string = ''
  @State maxTem: string = ''
  @State minTem: string = ''
  @State nowWea: string = ''
  @State airQuality: number = 0
  @State isRain: string = ''
  @State twentyFourHourWeatherList: twentyFourHourWeather | undefined = undefined
  @State airFor3Day: string[] = []
  @State WeatherColor: string = ''
  @State clothStr: string = ''
  @State SunStr: string = ''
  @State sportStr: string = ''
  @State washCarStr: string = ''
  @State fishingStr: string = ''
  @State coldStr: string = ''
  @State weatherPoints: weatherPoints | undefined = undefined
  @State isRefreshing: boolean = false
  @State refreshingText: string = ''
  @StorageLink('isNight') isNight: boolean = false
  @State titleColor: string = 'rgba(0, 0, 0, 1)'

  aboutToAppear(): void {
    this.fiveMinutesRainList = []
    const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    reqPermissionsFromUser(permissions, context);
    let request: geoLocationManager.SingleLocationRequest = {
      'locatingPriority': geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
      'locatingTimeoutMs': 10000
    }
    try {
      geoLocationManager.getCurrentLocation(request).then((result) => { // 调用getCurrentLocation获取当前设备位置，通过promise接收上报的位置
        console.log('current location: ' + JSON.stringify(result));
        this.result = result
        this.latitude = this.result.latitude
        this.longitude = this.result.longitude

        weatherModel.getWeatherPointsByHttp(`${this.longitude},${this.latitude}`)
          .then(weatherPoints => {
            this.weatherPoints = weatherPoints
            console.log('空气' + JSON.stringify(this.weatherPoints))
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

          )


        weatherModel.getCurrWeatherListByHttp(`${this.longitude},${this.latitude}`)
          .then(currWeather => {
            this.currWeather = currWeather
            this.nowTem = this.currWeather.now.temp
            this.nowWea = this.currWeather.now.text
            if (regExpUtil.getWea(this.nowWea)) {
              this.isRain = '正在下雨'
            } else {
              this.isRain = '两小时内无降雨'
            }
            console.log('按钮主页' + this.WeatherColor)
            if (this.isNight == true) {
              this.WeatherColor = 'rgba(0, 6, 41, 0.95)'
              this.titleColor = 'rgba(255, 255, 255, 1)'
            } else {
              this.titleColor = 'rgba(0, 0, 0, 1)'
              if (this.nowWea == '晴') {
                this.WeatherColor = 'rgb(57,127,213)'
              } else if (this.nowWea == '多云') {
                this.WeatherColor = 'rgb(127,154,201)'
              } else if (this.nowWea == '阴') {
                this.WeatherColor = 'rgb(141,161,185)'
              } else {
                this.WeatherColor = '#4c545c'
              }
            }
            console.log(`实时${this.currWeather.now.temp}`)
            console.log(`实时${this.currWeather.now.temp}`)
            let pos = this.currWeather?.fxLink.split('/');
            console.log('实时数组' + pos)
            let posnum_1 = pos[4]
            console.log('实时/切割结果' + posnum_1)
            let posnum_2 = posnum_1.split('-')[1]
            console.log('实时-切割结果' + posnum_2)
            let posnum_3 = posnum_2.split('.')[0]
            console.log('实时。切割结果' + posnum_3)
            this.locationNum = posnum_3
            weatherModel.getAirQualityListByHttp(this.locationNum)
              .then(val => {
                this.airQuality = Number(val.aqi[0].value)
                if (this.airQuality <= 50) {
                  this.clear = '空气优'
                } else if (this.airQuality <= 100) {
                  this.clear = '空气良'
                } else if (this.airQuality <= 150) {
                  this.clear = '轻度污染'
                } else if (this.airQuality <= 200) {
                  this.clear = '中度污染'
                } else if (this.airQuality <= 300) {
                  this.clear = '重度污染'
                } else {
                  this.clear = '严重污染'
                }
                console.log('质量' + typeof (this.airQuality))
              })
            weatherModel.getLocationListByHttp(posnum_3)
              .then(val => {
                this.title = val.location[0].adm1 + val.location[0].adm2 + '市' + val.location[0].name + '区'
                console.log('实时' + this.title)
              })

          })
        weatherModel.get3DayWeatherListByHttp(`${this.longitude},${this.latitude}`)
          .then(nwe3DWeather => {
            this.new3DWeather = nwe3DWeather
            this.maxTem = this.new3DWeather.daily[0].tempMax
            this.minTem = this.new3DWeather.daily[0].tempMin
            console.log(`我${this.new3DWeather.daily[0].sunrise}`)

          })

      })
        .catch((error: BusinessError) => { // 接收上报的错误码
          console.error('promise, getCurrentLocation: error=' + JSON.stringify(error));
        });
    } catch (err) {
      console.error("errCode:" + JSON.stringify(err));
    }


  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshItemBuilder }) {
      Column() {

        //标题栏
        Row() {
          Image($r('app.media.add'))
            .size({ width: 30, height: 30 })
            .onClick(() => {
              router.replaceUrl({
                url: 'pages/searchPage',
                params: { mainCode: this.locationNum }
              })
            })
          Text(this.title)
            .fontSize(25)
            .fontColor(this.titleColor)
          Image($r('app.media.ic_more'))
            .size({ width: 30, height: 30 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/settingPage'
              })
            })
        }
        .height(60)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 15, right: 15 })
        .backgroundColor(this.WeatherColor)


        List() {

          //实时天气
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

          //2小时降水
          if (regExpUtil.getWea(this.nowWea)) {
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
                // .backgroundColor(Color.Yellow)
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
                          console.log('我尼玛' + this.fiveMinutesRainList.toString())
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
                          console.log(`目前雨量${rainList.toString()}`)
                          for (this.i = 0; this.i < 24; this.i++) {
                            this.context.moveTo(35 + this.i * 13, 112)
                            this.context.lineTo(35 + this.i * 13, 112 - 92 * rainList[this.i])
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
          } else {
            ListItem() {
              Column() {
              }
              .height(80)
              .width('100%')
              .backgroundColor(Color.Transparent)
            }
          }


          //三日天气&15日天气
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
                // .backgroundColor(Color.Black)
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

          //24小时预报
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

                    .width(1500)
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
                            for (this.i = 1; this.i < 24; this.i++) {

                              this.context_2.fillText(`${tempList[this.i]}°`, 15 + 60 * this.i,
                                20 +
                                  (1 - (tempList[this.i] - minT) / (maxT - minT)) * 55)

                              this.context_2.lineTo(25 + 60 * this.i,
                                30 +
                                  (1 - (tempList[this.i] - minT) / (maxT - minT)) * 55)
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

          //风力风向、日出日落、湿度、体感温度、能见度、气压
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

          //天气指数
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
        .backgroundColor(this.WeatherColor)
        .height('100%')
        .scrollBar(BarState.Off)

        //
        // .backgroundImage($r('app.media.rain_background'))

      }
    }
    .onRefreshing(() => {
      this.refreshingText = '正在刷新...'
      this.aboutToAppear()
      setTimeout(() => {
        this.refreshingText = '刷新完成！'
      }, 2500)
      setTimeout(() => {
        this.isRefreshing = false
      }, 3000)


      console.log('onRefreshing test')
    })
    .refreshOffset(64)
    .pullToRefresh(true)
    .width('100%')
  }

  @Builder
  refreshItemBuilder() {
    Stack() {
      Row() {
        LoadingProgress().height(32)
        Text(this.refreshingText).fontSize(16).margin({ left: 20 })
      }.alignItems(VerticalAlign.Center)
    }.width("100%").align(Alignment.Center)
    .constraintSize({ minHeight: 32 })
  }
}