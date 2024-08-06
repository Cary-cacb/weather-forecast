 class RegExpUtil{

  getWea(str:string):boolean{
    const regex = /雨/
    return  regex.test(str)
  }
}
const regExpUtil = new RegExpUtil
 export default regExpUtil as RegExpUtil