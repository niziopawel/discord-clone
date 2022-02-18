import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messagesContainer"]

  connect() {
    this.element.scrollTop = this.element.scrollHeight - this.element.clientHeight

    const config = { attributes: true, childList: true, subtree: true }
    const observer = new MutationObserver(() => {
      this.resetScroll()
    })
    observer.observe(this.messagesContainerTarget, config)
  }

  resetScroll() {
    this.element.scrollTop = this.element.scrollHeight - this.element.clientHeight
  }
}
