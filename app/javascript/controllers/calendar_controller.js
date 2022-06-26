import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "selectedSlot", "timeInput" ]
  // static values = {
  //   to_unlist_id: String,
  //   to_list_id: String,
  // };

  connect() {
    console.log("hello from calendar_controller!")
  }

  hideBookForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-right");
    form.style.display = "none";
  }

  displayBookForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-right");
    form.style.display = "block";
    const time = event.target.innerHTML
    const date = event.target.id.split("|")[0]
    console.log(event)
    //`<input data-calendar-target="selectedSlot" type="text" name="timeslot" value="admin" style="pointer-events:none;">`
    this.selectedSlotTarget.outerHTML = `${date} ${time}`;
    this.timeInputTarget.innerHTML = `<input type="text" id="availability" name="availability" value="${event.target.id.split("|")[1]}">`
    this.timeInputTarget.style.display = "none"
  }


}
