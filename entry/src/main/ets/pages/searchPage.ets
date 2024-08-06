import MmkvModel from './ViewModel/MMKVModel'
import router from '@ohos.router'
import weatherModel from './ViewModel/HTTPModel';
import { possion } from './entity/Possion';
import { location } from './entity/location';
import { historyListItemViewModel } from './ViewModel/historyListViewModel';


class routerParams {
  mainCode: string

  constructor(mainCode: string) {
    this.mainCode = mainCode;
  }
}

@Entry
@Component
struct search {
  aboutToAppear() {
    this.codeSet = MmkvModel.getCodes()
    this.codeSet.forEach((val, index) => {
      if (val == '') {
        this.codeSet.splice(index, 1)
      } else {
      }
    })
    this.codeSet.forEach(val => {
      this.locationSet.push(JSON.parse(val))
    })
    this.locationSet.forEach(async (value, number) => {

      let curWea = await weatherModel.getCurrWeatherListByHttp(value.id)

      this.currWeatherList.push(curWea.now.temp)


      let dailyWea = await weatherModel.get3DayWeatherListByHttp(value.id)
      this.weatherList.push(`${dailyWea.daily[0].tempMax}°/${dailyWea.daily[0].tempMin}°`)
      this.mainCodeList.push(value.id)
      this.locationList.push(value.name)
    })

  }

  @State codeSet: string[] = []
  @State mainCode: string = (router.getParams() as routerParams).mainCode
  @State possion: possion | undefined = undefined
  @State isNull: number = 1
  @State locationSet: location[] = []
  //传入历史记录列表对象VM使用
  @State locationList: string[] = []
  @State weatherList: string[] = []
  @State currWeatherList: string[] = []
  @State mainCodeList: string[] = []

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .size({ width: 30, height: 30 })
          .onClick(() => {
            console.log('被点击 返回')
            router.replaceUrl({
              url: 'pages/routerIndex',
              params: { mainCode: this.mainCode }
            })

          })
          .margin({ left: 20 })
      }.justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({ bottom: 5 })

      Row() {
        Text('城市管理')
          .fontSize(30).fontWeight(FontWeight.Lighter)
          .margin({ left: 20 })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      Search({ placeholder: '搜索位置' })
        .searchButton('搜索')
        .onChange(value => {
          this.isNull = 1

        })
        .width('90%')
        .onSubmit((value: string) => {
          // if (value.length == 9) {
          //   if (this.codeSet.length < 10) {

          //
          //   } else {
          //     this.codeSet.pop()
          //     this.codeSet.unshift(value)
          //     MmkvModel.setCodes(this.codeSet)
          //   }
          // }
          weatherModel.getLocationListByHttp(value)
            .then(possion => {
              this.possion = possion
              this.isNull = 0
            })

          /*          router.replaceUrl({
                      url: 'pages/routerIndex',
                      params: { mainCode: value }
                    })*/
        })
      if (this.isNull != 1) {
        List() {
          ForEach(this.possion?.location, (value: location) => {
            ListItem() {
              Column() {
                Text(`${value.adm1} ${value.adm2} ${value.name}`)
                  .fontSize(20)
                Divider()

              }.width('100%')

            }.width('98%')
            .onClick(() => {
              if (this.codeSet.length < 3) {
                this.codeSet.unshift(JSON.stringify(value))
              } else {
                this.codeSet.unshift(JSON.stringify(value))
                this.codeSet.pop()


              }
              MmkvModel.setCodes(this.codeSet)
              router.replaceUrl({
                url: 'pages/routerIndex',
                params: { mainCode: value.id }
              })
            })
          })
        }
      }
      Row() {
        Text('历史搜索记录')
          .fontSize(15)
          .fontColor(Color.Gray)
      }.width('100%')
      .height(25)
      .padding({ top: 5, bottom: 5 })
      .justifyContent(FlexAlign.Start)

      historyListItemViewModel({
        locationList: this.locationList,
        weatherList: this.weatherList,
        currWeatherList: this.currWeatherList,
        codeSet: this.codeSet,
        mainCodeList: this.mainCodeList
      })

      Row() {
        Image($r('app.media.delete'))
          .size({ width: 15, height: 15 })
        Text('清空历史记录')
          .fontSize(15)
          .fontColor('#707070')
      }.height(18)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.codeSet = []
        MmkvModel.setCodes(this.codeSet)
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  historyItemBuilder(index: number) {
    Button() {
      Image($r('app.media.delete_history'))
        .size({ width: 50, height: 50 })

        .onClick(() => {
          this.locationSet.splice(index, 1)
          this.codeSet.splice(index, 1)
          MmkvModel.setCodes(this.codeSet)
        })
    }
    .backgroundColor(Color.Transparent)
    .width(80)
  }
}