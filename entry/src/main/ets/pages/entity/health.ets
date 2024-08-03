import { advice } from './advice'

export class health {
  effect: string
  advice: advice

  constructor(effect: string, advice: advice) {
    this.effect = effect
    this.advice = advice
  }
}