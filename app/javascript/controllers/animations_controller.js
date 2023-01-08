import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    window.debug("Animations Controller Connected")
    this.removeEffect = this.removeEffect.bind(this)
    this.element.addEventListener("transitionend", this.removeEffect)
    this.element.addEventListener("animationend", this.removeEffect)
  }

  disconnect() {
    window.debug("Animations Controller Disconnected")
    this.element.removeEventListener("transitionend", this.removeEffect)
    this.element.removeEventListener("animationend", this.removeEffect)
  }

  removeEffect() {
    [...event.target.classList].reverse().forEach( (klass) => {
         if(klass.match(/^effect-/)) event.target.classList.remove(klass)
      })

  }

}
