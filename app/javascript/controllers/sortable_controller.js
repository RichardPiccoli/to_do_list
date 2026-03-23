import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  // Valores que podem ser passados via data-attributes
  static values = {
    group: String,
    handle: String,
    animation: { type: Number, default: 150 },
    scroll: { type: Boolean, default: true },
    scrollSensitivity: { type: Number, default: 50 },   // aumenta sensibilidade
    scrollSpeed: { type: Number, default: 15 }          // aumenta velocidade
  }

  connect() {
    // Opções do Sortable
    const options = {
      group: this.groupValue || null,
      handle: this.handleValue || null,
      animation: this.animationValue,
      scroll: this.scrollValue,
      scrollSensitivity: this.scrollSensitivityValue,
      scrollSpeed: this.scrollSpeedValue,
      // Ignora elementos com data-sortable-ignore (impede arrasto e mantém cliques)
      filter: "[data-sortable-ignore]",
      // Permite que elementos filtrados ainda sejam clicáveis
      preventOnFilter: false,
      onEnd: this.onEnd.bind(this)
    }
    this.sortable = new Sortable(this.element, options)
  }

  disconnect() {
    if (this.sortable) this.sortable.destroy()
  }

  onEnd(event) {
    const { item, from, to, newIndex, oldIndex } = event

    // Se o elemento arrastado for um item de lista (board)
    if (this.element.id === "board_lists") {
      // Coleta os IDs das listas na ordem atual, ignorando o elemento fixo (nova lista)
      const listIds = Array.from(this.element.children)
        .filter(el => el.id && el.id.startsWith("list_") && !el.hasAttribute("data-sortable-ignore"))
        .map(el => el.id.replace("list_", ""))
      this.updateListOrder(listIds)
    }
    // Se for um item de tarefa (dentro de uma lista)
    else if (this.element.id.startsWith("lista_items_")) {
      const listId = this.element.id.replace("lista_items_", "")
      const itemIds = Array.from(this.element.children)
        .filter(el => el.id && el.id.startsWith("item_"))
        .map(el => el.id.replace("item_", ""))
      this.updateItemOrder(listId, itemIds)

      // Se foi movido para outra lista
      if (to !== from) {
        const newListId = to.id.replace("lista_items_", "")
        const itemId = item.id.replace("item_", "")
        this.moveItemToList(itemId, newListId, newIndex)
      }
    }
  }

  updateListOrder(listIds) {
    fetch("/lists/reorder", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ list_ids: listIds })
    })
  }

  updateItemOrder(listId, itemIds) {
    fetch(`/lists/${listId}/items/reorder`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ item_ids: itemIds })
    })
  }

  moveItemToList(itemId, newListId, newIndex) {
    fetch(`/items/${itemId}/move`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ list_id: newListId, position: newIndex })
    })
  }
}