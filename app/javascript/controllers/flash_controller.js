import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['content']

  connect() {
    console.log('Flash controller connected')
    window.setTimeout(this.close.bind(this), 10000)
  }

  close() {
    console.log('Flash controller close')
    this.contentTarget.classList.add('asHidden')
  }
}
