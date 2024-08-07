import DatabaseUtil from '../utils/sqlLiteUtil';
import router from '@ohos.router'

@Component
export struct historyListItemViewModel {
  @Link locationList: string[]
  @Link weatherList: string[]
  @Link currWeatherList: string[]
  @Link codeSet: string[]
  @Link mainCodeList: string[]

  build() {
    List() {
      ForEach(this.locationList, (value: string, index: number) => {
        if (this.codeSet) {
          ListItem() {
            Row() {
              Column() {
                Text(value)
                  .fontSize(25)
                  .fontColor(Color.White)

                Text(this.weatherList[index])
                  .fontSize(18)
                  .fontColor(Color.White)
              }.justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Start)
              .height('100%')

              Text(this.currWeatherList[index] + '°')
                .fontSize(45)
                .fontColor(Color.White)
            }
            .onClick(() => {
              router.replaceUrl({
                url: 'pages/routerIndex',
                params: { mainCode: this.mainCodeList[index] }
              })
            })
            .height('100%')
            .width('100%')
            .backgroundColor('rgb(57,127,213)')
            .justifyContent(FlexAlign.SpaceBetween)
            .borderRadius(20)
            .padding({ left: 20, right: 20 })
          }
          .padding({ left: 5, right: 5 })
          .margin({ bottom: 15 })
          .width('100%')
          .height(100)
          .swipeAction({
            end: {
              builder: () => this.historyItemBuilder(index),
              actionAreaDistance: 60
            }
          })
        }
      })
    }.width('97%')
  }

  @Builder
  historyItemBuilder(index: number) {
    Button() {
      Image($r('app.media.delete_history'))
        .size({ width: 50, height: 50 })
        .onClick(() => {
          this.locationList.splice(index, 1)
          this.weatherList.splice(index, 1)
          this.currWeatherList.splice(index, 1)
          this.codeSet.splice(index, 1)
          this.mainCodeList.splice(index, 1)
          DatabaseUtil.deleteAllHistory()
          this.codeSet.forEach((val) => {
            console.log('查询返回数值' + val)
            DatabaseUtil.addHistory(val)

          })
        })
    }
    .backgroundColor(Color.Transparent)
    .width(80)
  }
}