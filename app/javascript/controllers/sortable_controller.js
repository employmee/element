import { Controller } from "stimulus"
import Sortable from "sortablejs"
import { csrfToken } from "@rails/ujs";


export default class extends Controller {
  static targets = [ "selected" ]
  // static values = {
  //   to_unlist_id: String,
  //   to_list_id: String,
  // };

  connect() {
    console.log("hello from sortable_controller!")
    let listed = document.getElementById('listed');
    let unlisted = document.getElementById('unlisted');
    Sortable.create(listed, {
      group: 'subjects', // set both lists to same group
      animation: 150
    });

    Sortable.create(unlisted, {
      group: 'subjects',
      animation: 150
    });
  }
  updateListed(event) {
    // console.log(event)
    console.log(event.srcElement.id.split("-")[1])

    const subject_id = event.srcElement.id.split("-")[1]
    const condition1 = event.path.map(target => target.id).includes("listed")
    // const condition2 = (parentID == "unlisted" || parentParentID == "unlisted")
    if (condition1 ) {
      console.log("moved to listed")
      let formData = new FormData();
      formData.append('id', subject_id);
      formData.append('listed', true);
      fetch(`/subjects/${subject_id}`, {
        method: "PUT",
        headers: { Accept: "application/json", "X-CSRF-Token": csrfToken() },
        body: formData,
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
        });
    }
  }
  updateUnlisted(event) {
    // console.log(event)
    console.log(event.srcElement.id.split("-")[1])

    const subject_id = event.srcElement.id.split("-")[1]
    const condition1 = event.path.map(target => target.id).includes("unlisted")
    // const condition2 = (parentID == "listed" || parentParentID == "listed")
    if ( condition1 ) {
      console.log("moved to unlisted")
      let formData = new FormData();
      //formData.append('subject', JSON.stringify({id: subject_id, listed: false}));
      formData.append('id', subject_id);
      formData.append('listed', false);
      fetch(`/subjects/${subject_id}`, {
        method: "PUT",
        headers: { Accept: "application/json", "X-CSRF-Token": csrfToken() },
        body: formData,
      })
        .then((response) => console.log(response.json()))
        .then((data) => {
          console.log(data);
        });
    }
  }
}
