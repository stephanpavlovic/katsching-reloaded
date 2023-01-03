import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "area" ]

  scroll() {
    // window.scrollTo({top: 100, behavior: 'smooth'});
    if (this.hasAreaTarget) {
      this.areaTarget.scrollIntoView({ behavior: "smooth", block: "start",  inline: "nearest" });
    } else {
      this.element.scrollIntoView({ behavior: "smooth", block: "start",  inline: "nearest" });
    }
  }
}
