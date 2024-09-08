import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';
import weatherModel from './Model/HTTPModel'
import { CurrWeather } from './entity/currWeather'
import { dailyWeather } from './entity/dailyWeather';
import regExpUtil from './utils/RegExpUtil'
import { rainBarChartViewModel } from './ViewModel/index/rainBarChartViewModel';
import { dailyWeatherViewModel } from './ViewModel/index/dailyWeatherViewModel';
import { titleViewModel } from './ViewModel/index/titleCViewModel';
import { currWeatherViewModel } from './ViewModel/index/currWeatherViewModel';
import { twentyFourHourWeatherViewModel } from './ViewModel/index/twentyFourHourWeatherViewModel';
import { currWeatherGridViewModel } from './ViewModel/index/currWeatherGridViewModel';
import { airQuality } from './ViewModel/index/AirQualityViewModel';
import { JSON } from '@kit.ArkTS';

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
  @State airFor3Day: string[] = []
  @State WeatherColor: string = ''
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
        this.result = result
        this.latitude = this.result.latitude
        this.longitude = this.result.longitude

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
            let pos = this.currWeather?.fxLink.split('/');
            let posnum_1 = pos[4]
            let posnum_2 = posnum_1.split('-')[1]
            let posnum_3 = posnum_2.split('.')[0]
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
              })
            weatherModel.getLocationListByHttp(posnum_3)
              .then(val => {
                this.title = val.location[0].adm1 + val.location[0].adm2 + '市' + val.location[0].name + '区'
              })

          })
        weatherModel.get3DayWeatherListByHttp(`${this.longitude},${this.latitude}`)
          .then(nwe3DWeather => {
            this.new3DWeather = nwe3DWeather
            this.maxTem = this.new3DWeather.daily[0].tempMax
            this.minTem = this.new3DWeather.daily[0].tempMin
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
        Blank()
          .height(30)
          .backgroundColor(this.WeatherColor)
        titleViewModel({
          WeatherColor: this.WeatherColor,
          locationNum: this.locationNum,
          title: this.title,
          titleColor: this.titleColor
        })
        List() {
          //实时天气
          currWeatherViewModel({
            currWeather: this.currWeather,
            nowWea: this.nowWea,
            maxTem: this.maxTem,
            minTem: this.minTem,
            clear: this.clear,
            airQuality: this.airQuality,
            isRain: this.isRain
          })

          //2小时降水
          if (regExpUtil.getWea(this.nowWea)) {
            //2小时雨量图
            rainBarChartViewModel()
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
          dailyWeatherViewModel({
            new3DWeather: this.new3DWeather,
            longitude: this.longitude,
            latitude: this.latitude
          })

          //24小时预报
          twentyFourHourWeatherViewModel()

          //风力风向、日出日落、湿度、体感温度、能见度、气压
          currWeatherGridViewModel({ currWeather: this.currWeather, new3DWeather: this.new3DWeather })

          //天气指数
          airQuality({
            latitude: this.latitude,
            longitude: this.longitude,
            currWeather: this.currWeather,
            new3DWeather: this.new3DWeather,
            WeatherColor: this.WeatherColor,
            airQuality: this.airQuality
          })

          ListItem() {
            Column() {
              Blank().height(80)
            }
          }
        }
        .backgroundColor(this.WeatherColor)
        .scrollBar(BarState.Off)

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