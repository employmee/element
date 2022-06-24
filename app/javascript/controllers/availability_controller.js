import { Controller } from "stimulus"
import Sortable from "sortablejs"
import { csrfToken } from "@rails/ujs";


export default class extends Controller {
  static targets = [  ]
  // static values = {
  //   to_unlist_id: String,
  //   to_list_id: String,
  // };

  connect() {
    console.log("hello from availability_controller!")
  }

  displayScheduleForm() {
    const form = document.getElementById("overlay-left")
    form.style.display = "block";
  }

  hideScheduleForm() {
    const form = document.getElementById("overlay-left")
    form.style.display = "none";
  }

  displayAvailForm() {
    const form = document.getElementById("overlay-right")
    form.style.display = "block";
  }
}
