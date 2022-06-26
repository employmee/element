import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";


export default class extends Controller {
  static targets = [ "deleteBtn", "confirmBtn", "deleteMode" ]
  // static values = {
  //   to_unlist_id: String,
  //   to_list_id: String,
  // };

  connect() {
    console.log("hello from availability_controller!")
  }

  displayScheduleForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-left");
    form.style.display = "block";
  }

  hideScheduleForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-left");
    form.style.display = "none";
  }
  hideAvailForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-right");
    form.style.display = "none";
  }

  displayAvailForm(event) {
    event.preventDefault();
    const form = document.getElementById("overlay-right");
    form.style.display = "block";
  }

  deleteMode(event) {
    event.preventDefault();
    let deleteBtn = this.deleteBtnTarget;
    const confirmBtn = this.confirmBtnTarget;
    confirmBtn.style.display = "block";
    deleteBtn.outerHTML = `<button data-availability-target="deleteMode" data-action="click->availability#HideDeleteMode" class="btn-outline-red mx-2">delete mode</button>`
  }
  HideDeleteMode(event) {
    event.preventDefault();
    let deleteMode = this.deleteModeTarget;
    const confirmBtn = this.confirmBtnTarget;
    confirmBtn.style.display = "none";
    deleteMode.outerHTML = `<button data-availability-target="deleteBtn" data-action="click->availability#deleteMode" class="btn-square center mx-2" style="background-color:#A63D40;"><i class="fa-solid fa-minus" style="color:white"></i></button>`

    // Turn back all selected slots to normal slots without the highlighted style
    const selectedSlots = document.querySelectorAll(".month_selected")
    selectedSlots.forEach(slot => slot.className = "month_available")
  }

  highlightSlot(event) {
    event.preventDefault();
    const confirmBtn = this.confirmBtnTarget;
    // Only highlight if in delete mode
    if (confirmBtn.style.display === "block") {
      console.log(event.path)
      if (event.path.find(element => element.className == "month_available" )) {
        const slot = event.path.find(element => element.className.includes("month_available"))
        slot.className = "month_selected"
      } else if (event.path.find(element => element.className == "month_selected")) {
        const slot = event.path.find(element => element.className.includes("month_selected"))
        slot.className = "month_available"
      }
    }
  }

  deleteSelected(event) {
    event.preventDefault();
    let selected = document.getElementsByClassName("month_selected")
    let selected_ids = []
    Array.from(selected).forEach(ele => selected_ids.push(ele.id));
    console.log(selected_ids)
    selected_ids.forEach(id => {
      console.log(id)
      fetch(`/availabilities/${id}`, {
        method: "DELETE",
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'X-CSRF-Token': csrfToken()
        }
      })
      .then(res => res.json())
      })
    location.reload();
  }
}
