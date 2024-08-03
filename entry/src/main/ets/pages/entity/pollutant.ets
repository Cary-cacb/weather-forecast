import { concentration } from './concentration'
import { subIndex } from './subIndex'

export class pollutant {
  code: string
  name: string
  fullName: string
  concentration: concentration
  subIndex: subIndex

  constructor(code: string, name: string, fullName: string, concentration: concentration, subIndex: subIndex) {
    this.code = code
    this.name = name
    this.fullName = fullName
    this.concentration = concentration
    this.subIndex = subIndex
  }

}