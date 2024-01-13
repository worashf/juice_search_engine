// app/javascript/controllers/search-form_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "textInput", "confirmedInput" ];

  connect() {
    this.textInputTarget.addEventListener("focusout", () => this.handleFocusOut());
    this.textInputTarget.addEventListener("focusin", () => this.handleFocusIn());
  }

  handleFocusOut() {
    this.confirmedInputTarget.value = true;
    this.element.requestSubmit();
  }

  handleFocusIn() {
    this.confirmedInputTarget.value = null;
  }

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => this.element.requestSubmit(), 1000);
  }
}
