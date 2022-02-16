import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.scrollTop = this.element.scrollHeight - this.element.clientHeight

    const config = { attributes: true, childList: true, subtree: true }
    const observer = new MutationObserver(() => {
      this.resetScroll()
    })
    const messages = document.getElementById('messages')
    observer.observe(messages, config)
  }

  resetScroll() {
    this.element.scrollTop = this.element.scrollHeight - this.element.clientHeight
  }
}
