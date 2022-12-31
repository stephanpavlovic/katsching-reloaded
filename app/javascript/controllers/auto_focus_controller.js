import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.focus();
    this.element.scrollTop = this.element.scrollHeight;
    const { value } = this.element;
    if (value) {
      // This sets the cursor at the end of an input
      this.element.value = "";
      this.element.value = value;
    }
  }
}
