import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["input"]

  handleSubmit() {
    this.inputTarget.innerHTML = ''
  }
}
