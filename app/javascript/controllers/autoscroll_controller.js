import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  scroll() {
    this.element.scrollTop = this.element.scrollHeight;
  }
}
