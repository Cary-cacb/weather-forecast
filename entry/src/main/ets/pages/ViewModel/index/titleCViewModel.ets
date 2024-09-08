import { router } from '@kit.ArkUI'
@Component
export struct titleViewModel {
  @Link locationNum: string
  @Link title: string
  @Link titleColor: string
  @Link WeatherColor: string
  build() {
    //标题栏
    Row() {
      Image($r('app.media.add'))
        .addStyles()

      Text(this.title)
        .fontSize(25)
        .fontColor(this.titleColor)

      Image($r('app.media.ic_more'))
        .moreStyles()
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .rowStyles()
  }

  @Styles
  addStyles(){
    .size({ width: 30, height: 30 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/searchPage',
        params: { mainCode: this.locationNum }
      })
    })
  }

  @Styles
  moreStyles() {
    .size({ width: 30, height: 30 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/settingPage'
      })
    })
  }

  @Styles
  rowStyles(){
    .height(60)
    .width('100%')
    .padding({ left: 15, right: 15 })
    .backgroundColor(this.WeatherColor)
  }
}