import { CurrWeather } from '../entity/currWeather'
import { dailyWeather } from '../entity/dailyWeather'
import http from '@ohos.net.http'
import { possion } from '../entity/Possion'
import { airQuality } from '../entity/airQuality'
import { fiveMinutesRain } from '../entity/fiveMinutesRain'
import { twentyFourHourWeather } from '../entity/twentyFourHourWeather'
import { weatherPoints } from '../entity/weatherPoints'

class HTTPModel {
  baseURL: string = 'https://api.qweather.com/v7/weather'

  getCurrWeatherListByHttp(location: string): Promise<CurrWeather> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `${this.baseURL}/now`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取实时天气成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '实时天气查询失败！error:', JSON.stringify(resp))
            reject('实时天气列表查询失败')
          }
        })

    })
  }

  get3DayWeatherListByHttp(location: string): Promise<dailyWeather> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `${this.baseURL}/3d`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取近3日天气成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '近3日天气查询失败！error:', JSON.stringify(resp))
            reject('近3日天气列表查询失败')
          }
        })

    })
  }

  get15DayWeatherListByHttp(location: string): Promise<dailyWeather> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `${this.baseURL}/15d`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取近3日天气成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '近3日天气查询失败！error:', JSON.stringify(resp))
            reject('近3日天气列表查询失败')
          }
        })

    })
  }

  getLocationListByHttp(location: string): Promise<possion> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `https://geoapi.qweather.com/v2/city/lookup`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取地理位置成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '地理位置查询失败！error:', JSON.stringify(resp))
            reject('地理位置列表查询失败')
          }
        })

    })
  }

  getAirQualityListByHttp(location: string): Promise<airQuality> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `https://api.qweather.com/airquality/v1/now/${location}`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3' }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取空气质量信息成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '空气质量信息查询失败！error:', JSON.stringify(resp))
            console.log(`testTag  https://api.qweather.com/airquality/v1/now/${location}`)
            reject('空气质量信息查询失败')
          }
        })

    })
  }

  getMinutelyRainListByHttp(location: string): Promise<fiveMinutesRain> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `https://api.qweather.com/v7/minutely/5m`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': location }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取雨量信息成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '雨量信息查询失败！error:', JSON.stringify(resp))
            reject('雨量信息查询失败')
          }
        })

    })
  }

  get24HourWeatherListByHttp(location: string): Promise<twentyFourHourWeather> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `https://api.qweather.com/v7/weather/24h`,
        {
          method: http.RequestMethod.GET,
          extraData: { "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取24小时天气成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '24小时天气查询失败！error:', JSON.stringify(resp))
            reject('24小时天气列表查询失败')
          }
        })

    })
  }

  getWeatherPointsByHttp(location: string): Promise<weatherPoints> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `https://api.qweather.com/v7/indices/3d`,
        {
          method: http.RequestMethod.GET,
          extraData: { type: '0', "key": '26e5f5ab269b45b18579228a1c5cd1a3', 'location': `${location}` }
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('testTag', '获取天气指数预报成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '天气指数预报查询失败！error:', JSON.stringify(resp))
            reject('天气指数预报查询失败')
          }
        })

    })
  }
}


const weatherModel = new HTTPModel()

export default weatherModel as HTTPModel

//    private String pagesize;
//     private String page;
//     private String id;