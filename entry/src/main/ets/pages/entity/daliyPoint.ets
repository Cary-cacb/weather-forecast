export class dailyPoint{
  date:string
  type:string
  name:string
  level:string
  category:string
  text:string
  constructor(date: string, type: string, name: string, level: string, category: string, text: string) {
    this.date = date
    this.type = type
    this.name = name
    this.level = level
    this.category = category
    this.text = text
  }


}