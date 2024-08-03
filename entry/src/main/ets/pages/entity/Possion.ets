import { location } from './location'
import { refer } from './refer'

export class possion{
  code:string
  location:location[]
  refer:refer

  constructor(code: string, location: location[], refer: refer) {
    this.code = code
    this.location = location
    this.refer = refer
  }

}