import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [  ]
  // static values = {
  //   to_unlist_id: String,
  //   to_list_id: String,
  // };

  connect() {
    console.log("hello from booking_controller!")
  }

  updateBookingCancel(event) {
    event.preventDefault();
  }

  updateBookingConfirm(event) {
    event.preventDefault();
  }
}
