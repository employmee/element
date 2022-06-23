import { Controller } from "stimulus"
import Sortable from "sortablejs"


export default class extends Controller {
  static targets = [ "selected" ]

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
    const listed = document.querySelector('#listed');
  }
}
