import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.setupFlashMessages()
  }

  setupFlashMessages() {
    // Seleciona todas as mensagens dentro deste elemento
    const messages = this.element.querySelectorAll('.flash-message')
    messages.forEach(message => {
      setTimeout(() => {
        message.remove()
      }, 3000)
    })
  }
}