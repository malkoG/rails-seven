import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";
export default class extends Controller {
  static targets = [ "number", "newlink" ]
  static values = {
    createUrl: String,
    newUrl: String,
  }

  verify(event) {
    event.preventDefault()
    const value = this.numberTarget.value
    const token = Rails.csrfToken()
    const body = { verified_code: { phone: value } }
    fetch(this.createUrlValue, {
      method: 'post',
      headers: {
        'X-CSRF_Token': token,
        'X-CSRF-TOKEN': token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body)
      // credentials: "same-origin"
    })
    const href = this.newUrlValue + "?phone=" + value
    this.newlinkTarget.setAttribute("href", href)
    this.newlinkTarget.click();
  }
}
