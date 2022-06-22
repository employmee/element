import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "selected" ]

  connect() {
    console.log("hello from sign_up_controller!")
  }
  updateSelected(event) {
    console.log(event);
    console.log(this.selectedTarget)
  }
}
