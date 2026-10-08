import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    duration: { type: Number, default: 4000 }
  }

  connect() {
    requestAnimationFrame(() => {
      this.element.classList.remove("translate-y-full", "opacity-0")
      this.element.classList.add("translate-y-0", "opacity-100")
    })

    this.timeout = setTimeout(() => {
      this.close()
    }, this.durationValue)
  }

  close() {
    clearTimeout(this.timeout)

    this.element.classList.remove("translate-y-0", "opacity-100")
    this.element.classList.add("translate-y-full", "opacity-0")

    this.element.addEventListener(
      "transitionend",
      () => this.element.remove(),
      { once: true }
    )
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
