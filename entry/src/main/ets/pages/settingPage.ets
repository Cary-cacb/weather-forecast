import { router } from '@kit.ArkUI'

@Entry
@Component
struct settingPage {
  @StorageLink('isNight') isNight: boolean = false

  build() {
    Column() {
      Row() {
        Button() {
          Image($r('app.media.back'))
            .size({ width: 30, height: 30 })
        }
        .onClick(() => {
          router.back()
        })
        .backgroundColor(Color.Transparent)
        .size({ width: 30, height: 30 })
      }.justifyContent(FlexAlign.Start)
      .margin({ left: 15 })
      .width('100%')

      Blank()
        .height(30)
      Divider()
        .width('90%')
        .color('rgba(133, 133, 133, 0.82)')
      Row() {
        Text('夜间模式')
          .fontSize(30)
        Toggle({ type: ToggleType.Switch, isOn: $$this.isNight })
          .onChange(isOn => {
            this.isNight = isOn
            console.log('按钮' + this.isNight + '/' + isOn)
          })
          .width(50)
          .height(30)
      }.width('95%')
    }.width('100%')
  }
}