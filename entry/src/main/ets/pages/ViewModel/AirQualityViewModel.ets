import { CurrWeather } from '../entity/currWeather'
import { dailyWeather } from '../entity/dailyWeather'
import { weatherPoints } from '../entity/weatherPoints'
import weatherModel from '../Model/HTTPModel'

@Component
export struct airQuality {
  @State clothStr0: string = ''
  @State clothStr1: string = ''
  @State clothStr2: string = ''
  @State SunStr0: string = ''
  @State SunStr1: string = ''
  @State SunStr2: string = ''
  @State sportStr0: string = ''
  @State sportStr1: string = ''
  @State sportStr2: string = ''
  @State weatherPoints: weatherPoints | undefined = undefined
  @Link longitude: number
  @Link latitude: number
  @Link currWeather: CurrWeather
  @Link new3DWeather: dailyWeather
  @State clothTitle: string = ''
  @State isShow1: boolean = false
  @State isShow2: boolean = false
  @State isShow3: boolean = false
  @State isShow4: boolean = false
  @State isShow5: boolean = false
  @State isShow6: boolean = false
  @Link WeatherColor: string
  @Link airQuality: number

  aboutToAppear(): void {
    weatherModel.getWeatherPointsByHttp(`${this.longitude},${this.latitude}`)
      .then(weatherPoints => {
        this.weatherPoints = weatherPoints
        switch (Number(this.weatherPoints.daily[0].level)) {
          case (1):
            this.sportStr0 = '宜户外运动'
          case (2):
            this.sportStr0 = '较适宜'
          case (3):
            this.sportStr0 = '宜室内运动'
        }
        switch (Number(this.weatherPoints.daily[16].level)) {
          case (1):
            this.sportStr1 = '宜户外运动'
          case (2):
            this.sportStr1 = '较适宜'
          case (3):
            this.sportStr1 = '宜室内运动'
        }
        switch (Number(this.weatherPoints.daily[32].level)) {
          case (1):
            this.sportStr2 = '宜户外运动'
          case (2):
            this.sportStr2 = '较适宜'
          case (3):
            this.sportStr2 = '宜室内运动'
        }


        switch (Number(this.weatherPoints.daily[2].level)) {
          case 1:
            this.clothStr0 = '注意防寒';
            break
          case 2:
            this.clothStr0 = '注意保暖';
            break
          case 3:
            this.clothStr0 = '适当加衣';
            break
          case 4:
            this.clothStr0 = '适宜长袖';
            break
          case 5:
            this.clothStr0 = '适宜短袖';
            break
          case 6:
            this.clothStr0 = '适宜短袖';
            break
          case 7:
            this.clothStr0 = '适宜短袖';
            break
        }
        switch (Number(this.weatherPoints.daily[18].level)) {
          case 1:
            this.clothStr1 = '注意防寒';
            break
          case 2:
            this.clothStr1 = '注意保暖';
            break
          case 3:
            this.clothStr1 = '适当加衣';
            break
          case 4:
            this.clothStr1 = '适宜长袖';
            break
          case 5:
            this.clothStr1 = '适宜短袖';
            break
          case 6:
            this.clothStr1 = '适宜短袖';
            break
          case 7:
            this.clothStr1 = '适宜短袖';
            break
        }
        switch (Number(this.weatherPoints.daily[34].level)) {
          case 1:
            this.clothStr2 = '注意防寒';
            break
          case 2:
            this.clothStr2 = '注意保暖';
            break
          case 3:
            this.clothStr2 = '适当加衣';
            break
          case 4:
            this.clothStr2 = '适宜长袖';
            break
          case 5:
            this.clothStr2 = '适宜短袖';
            break
          case 6:
            this.clothStr2 = '适宜短袖';
            break
          case 7:
            this.clothStr2 = '适宜短袖';
            break
        }


        switch (Number(this.weatherPoints.daily[15].level)) {
          case 1:
            this.SunStr0 = '无需防晒';
            break
          case 2:
            this.SunStr0 = '无需防晒';
            break
          case 3:
            this.SunStr0 = '不是很晒';
            break
          case 4:
            this.SunStr0 = '涂防晒霜';
            break
          case 5:
            this.SunStr0 = '涂防晒霜';
            break
        }
        switch (Number(this.weatherPoints.daily[31].level)) {
          case 1:
            this.SunStr1 = '无需防晒';
            break
          case 2:
            this.SunStr1 = '无需防晒';
            break
          case 3:
            this.SunStr1 = '不是很晒';
            break
          case 4:
            this.SunStr1 = '涂防晒霜';
            break
          case 5:
            this.SunStr1 = '涂防晒霜';
            break
        }
        switch (Number(this.weatherPoints.daily[47].level)) {
          case 1:
            this.SunStr2 = '无需防晒';
            break
          case 2:
            this.SunStr2 = '无需防晒';
            break
          case 3:
            this.SunStr2 = '不是很晒';
            break
          case 4:
            this.SunStr2 = '涂防晒霜';
            break
          case 5:
            this.SunStr2 = '涂防晒霜';
            break
        }
      }
      )
  }

  build() {
    ListItem() {
      Grid() {
        GridItem() {
          //穿衣指数
          Column({ space: 15 }) {
            Image($r('app.media.cloth'))
              .size({ width: 60, height: 60 })

            Text(this.clothStr0)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')
        .onClick(() => {
          this.isShow1 = true
        })
        .bindSheet($$this.isShow1, this.clothBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false
        })

        //防晒指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.sunshine'))
              .size({ width: 60, height: 60 })

            Text(this.SunStr0)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')
        .onClick(() => {
          this.isShow2 = true
        })
        .bindSheet($$this.isShow2, this.sunBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false
        })

        //运动指数
        GridItem() {
          Column({ space: 15 }) {
            Image($r('app.media.sports'))
              .size({ width: 50, height: 45 })

            Text(this.sportStr0)
              .fontSize(20)
              .fontColor(Color.White)

          }.size({ width: '100%', height: '100%' })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }.backgroundColor('rgba(226, 226, 226, 0.3)')
        .onClick(() => {
          this.isShow3 = true
        })
        .bindSheet($$this.isShow3, this.sportBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false

        })

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
        .onClick(() => {
          this.isShow4 = true
        })
        .bindSheet($$this.isShow4, this.washBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false
        })


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
        .onClick(() => {
          this.isShow5 = true
        })
        .bindSheet($$this.isShow5, this.fishingBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false
        })


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
        .onClick(() => {
          this.isShow6 = true
        })
        .bindSheet($$this.isShow6, this.coldBindSheetBuilder(), {
          detents: ['60%', '60%', 200],
          dragBar: true,
          backgroundColor: this.WeatherColor,
          showClose: false
        })

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

  @Builder
  clothBindSheetBuilder() {
    Column() {
      Row() {
        Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
          `${this.new3DWeather.daily[0].textDay}` :
          `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`${this.new3DWeather.daily[0].tempMax}°/${this.new3DWeather.daily[0].tempMin}°`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(this.clothStr0)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[2].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`${this.new3DWeather.daily[0].tempMax}°/${this.new3DWeather.daily[0].tempMin}°`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.cloth'))
            .size({ width: 40, height: 40 })
          Text(this.clothStr0)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`${this.new3DWeather.daily[1].tempMax}°/${this.new3DWeather.daily[1].tempMin}°`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.cloth'))
            .size({ width: 40, height: 40 })
          Text(this.clothStr1)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`${this.new3DWeather.daily[2].tempMax}°/${this.new3DWeather.daily[2].tempMin}°`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.cloth'))
            .size({ width: 40, height: 40 })
          Text(this.clothStr2)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
  }

  @Builder
  sunBindSheetBuilder() {
    Column() {
      Row() {
        Text(this.SunStr0)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`紫外线指数: ${this.weatherPoints?.daily[15].level}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(this.SunStr0)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[15].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`紫外线${this.weatherPoints?.daily[15].category}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sunshine'))
            .size({ width: 40, height: 40 })
          Text(this.SunStr0)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`紫外线${this.weatherPoints?.daily[31].category}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sunshine'))
            .size({ width: 40, height: 40 })
          Text(this.SunStr1)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(`紫外线${this.weatherPoints?.daily[47].category}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sunshine'))
            .size({ width: 40, height: 40 })
          Text(this.SunStr2)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  sportBindSheetBuilder() {
    Column() {
      Row() {
        Text('空气 优 ')
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`${this.airQuality}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(this.sportStr0)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[0].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text('空气优')
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sports'))
            .size({ width: 35, height: 30 })
          Text(this.sportStr0)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text('空气优')
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sports'))
            .size({ width: 35, height: 30 })
          Text(this.sportStr1)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text('空气优')
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.sports'))
            .size({ width: 35, height: 30 })
          Text(this.sportStr2)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
  }

  @Builder
  washBindSheetBuilder() {
    Column() {
      Row() {
        Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
          `${this.new3DWeather.daily[0].textDay}` :
          `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`${this.new3DWeather.daily[0].tempMax}°/${this.new3DWeather.daily[0].tempMin}°`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(`${this.weatherPoints?.daily[1].category}洗车`)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[1].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
            `${this.new3DWeather.daily[0].textDay}` :
            `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.car'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[1].category}洗车`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[1].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[1].textDay}` :
            `${this.new3DWeather.daily[1].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.car'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[17].category}洗车`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[2].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[2].textDay}` :
            `${this.new3DWeather.daily[2].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.car'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[33].category}洗车`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  fishingBindSheetBuilder() {
    Column() {
      Row() {
        Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
          `${this.new3DWeather.daily[0].textDay}` :
          `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`${this.new3DWeather.daily[0].tempMax}°/${this.new3DWeather.daily[0].tempMin}°`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(`${this.weatherPoints?.daily[3].category}钓鱼`)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[3].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
            `${this.new3DWeather.daily[0].textDay}` :
            `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.fishing'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[3].category}钓鱼`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[1].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[1].textDay}` :
            `${this.new3DWeather.daily[1].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.fishing'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[19].category}钓鱼`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[2].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[2].textDay}` :
            `${this.new3DWeather.daily[2].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.fishing'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[35].category}钓鱼`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  coldBindSheetBuilder() {
    Column() {
      Row() {
        Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
          `${this.new3DWeather.daily[0].textDay}` :
          `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .margin({ right: 10 })
        Text(`${this.new3DWeather.daily[0].tempMax}°/${this.new3DWeather.daily[0].tempMin}°`)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)

      }.justifyContent(FlexAlign.Start)
      .width('95%')
      .height(16)
      .margin({ bottom: 25, top: 40 })

      Row() {
        Text(`${this.weatherPoints?.daily[8].category}感冒`)
          .fontSize(40)
          .fontColor(Color.White)
      }.width('95%')
      .height(40)
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.weatherPoints?.daily[8].text)
          .fontSize(16)
          .fontColor(Color.White)
      }.height(16)
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .height(100)
      Row() {
        Column({ space: 10 }) {
          Text('今天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[0].textDay == this.new3DWeather.daily[0].textNight ?
            `${this.new3DWeather.daily[0].textDay}` :
            `${this.new3DWeather.daily[0].textDay}转${this.new3DWeather.daily[0].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.jiaonang'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[8].category}感冒`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('明天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[1].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[1].textDay}` :
            `${this.new3DWeather.daily[1].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.jiaonang'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[24].category}感冒`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)

        Column({ space: 10 }) {
          Text('后天')
            .fontColor(Color.White)
            .fontSize(20)
          Text(this.new3DWeather.daily[2].textDay == this.new3DWeather.daily[1].textNight ?
            `${this.new3DWeather.daily[2].textDay}` :
            `${this.new3DWeather.daily[2].textDay}转${this.new3DWeather.daily[1].textNight}`)
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('app.media.jiaonang'))
            .size({ width: 40, height: 40 })
          Text(`${this.weatherPoints?.daily[40].category}感冒`)
            .fontColor(Color.White)
            .fontSize(20)
        }.justifyContent(FlexAlign.Center)
      }.width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}