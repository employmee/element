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
    const bookingId = event.target.id.split(" ")[1]
    console.log(bookingId)
    let formData = new FormData();
      formData.append('id', bookingId);
      formData.append('status', "cancelled");
      fetch(`/bookings/${bookingId}`, {
        method: "PUT",
        headers: { Accept: "application/json", "X-CSRF-Token": csrfToken() },
        body: formData,
      })
        .then((response) => console.log(response.json()))
        .then((data) => {
          console.log(data);
        });
    location.reload();
  }

  updateBookingConfirm(event) {
    event.preventDefault();
    const bookingId = event.target.id.split(" ")[1]
    console.log(bookingId)
    let formData = new FormData();
      formData.append('id', bookingId);
      formData.append('status', "confirmed");
      fetch(`/bookings/${bookingId}`, {
        method: "PUT",
        headers: { Accept: "application/json", "X-CSRF-Token": csrfToken() },
        body: formData,
      })
        .then((response) => console.log(response.json()))
        .then((data) => {
          console.log(data);
        });
    location.reload();
  }
}
