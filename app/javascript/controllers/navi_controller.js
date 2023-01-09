import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "hamburger", "menu" ]

  toggle() {
    this.hamburgerTarget.classList.toggle("active");
    this.menuTarget.classList.toggle("active");
  }

  close() {
    this.hamburgerTarget.classList.remove("active");
    this.menuTarget.classList.remove("active");
  }
}
