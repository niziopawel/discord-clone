import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    const loggedInUserId = document.querySelector('body').dataset.viewerId

    const messages = this.element.querySelectorAll('div[id^="message"]')

    messages.forEach(message => {
      const authorId = message.dataset.authorId
      if (loggedInUserId === authorId) {
        const href = message.dataset.href
        const editBtn = this.createEditButton(href)

        message.appendChild(editBtn)
      }
    })

    const config = { attributes: false, childList: true, subtree: false }
    const observer = new MutationObserver((mutationList, observer) => {
      for (const mutation of mutationList) {
        const newMessage = mutation.addedNodes[2].firstElementChild
        const authorId = newMessage.dataset.authorId

        if (loggedInUserId === authorId) {
          const href = newMessage.dataset.href
          const editBtn = this.createEditButton(href)

          newMessage.appendChild(editBtn)
        }
      }
    })
    observer.observe(this.element, config)
  }

  createEditButton(href) {
    const editBtn = document.createElement('a')
    const link = document.createTextNode('Edit')
    editBtn.appendChild(link)

    editBtn.href = href
    return editBtn
  }
}
