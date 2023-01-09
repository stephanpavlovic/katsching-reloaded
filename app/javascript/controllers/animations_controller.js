import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.removeEffect = this.removeEffect.bind(this)
    this.element.addEventListener("transitionend", this.removeEffect)
    this.element.addEventListener("animationend", this.removeEffect)
  }

  disconnect() {
    this.element.removeEventListener("transitionend", this.removeEffect)
    this.element.removeEventListener("animationend", this.removeEffect)
  }

  removeEffect() {
    [...event.target.classList].reverse().forEach( (klass) => {
         if(klass.match(/^effect-/)) event.target.classList.remove(klass)
      })

  }

}
