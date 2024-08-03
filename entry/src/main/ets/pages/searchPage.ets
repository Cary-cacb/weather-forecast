import MmkvModel from './ViewModel/MMKVModel'
import router from '@ohos.router'


class routerParams {
  mainCode: string

  constructor(mainCode: string) {
    this.mainCode = mainCode;
  }
}

@Entry
@Component
struct search {
  aboutToAppear(): void {
    this.codeSet = MmkvModel.getCodes()

  }

  @State codeSet: string[] = []
  @State mainCode: string = (router.getParams() as routerParams).mainCode

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
      }

      Search({ placeholder: '请输入 LocationID ...' })
        .searchButton('搜索')

        .onSubmit((value: string) => {
          if (value.length == 9) {
            if (this.codeSet.length < 10) {
              this.codeSet.unshift(value)
              MmkvModel.setCodes(this.codeSet)

            } else {
              this.codeSet.pop()
              this.codeSet.unshift(value)
              MmkvModel.setCodes(this.codeSet)
            }
          }

          router.replaceUrl({
            url: 'pages/routerIndex',
            params: { mainCode: value }
          })
        })
      Row() {
        Text('历史搜索记录')
          .fontSize(15)
          .fontColor(Color.Gray)
      }.width('100%')
      .height(25)
      .padding({ top: 5, bottom: 5 })
      .justifyContent(FlexAlign.Start)

      List() {
        ForEach(this.codeSet, (value: string) => {
          ListItem() {
            Column() {
              Text(value)
                .fontSize(40)
              Divider()
                .strokeWidth(2)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .height(60)
            .onClick(() => {
              console.log('历史纪录被点击！')
              router.replaceUrl({
                url: 'pages/routerIndex',
                params: { mainCode: value }
              })
            })
          }.width('100%')
          .height(60)

        })
      }.width('100%')
      .height(600)
    }
    .width('100%')
    .height('100%')
  }
}