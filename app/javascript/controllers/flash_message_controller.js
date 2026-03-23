import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Define um valor padrão de timeout (pode ser sobrescrito com data-flash-message-timeout)
  static values = { timeout: Number }

  connect() {
    // Quando a mensagem é conectada ao DOM, agenda sua remoção
    const timeoutMs = this.timeoutValue || 3000 // 3 segundos padrão
    this.timeoutId = setTimeout(() => {
      this.element.remove() // remove o elemento do DOM
    }, timeoutMs)
  }

  disconnect() {
    // Se o elemento for removido antes do timeout, cancela o temporizador
    if (this.timeoutId) clearTimeout(this.timeoutId)
  }
}