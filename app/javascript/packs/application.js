// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require sortable.min

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// let listed = document.getElementById('listed');
// let unlisted = document.getElementById('unlisted');
// Sortable.create(listed, {
//   group: 'subjects', // set both lists to same group
//   animation: 150
// });

// Sortable.create(unlisted, {
//   group: 'subjects',
//   animation: 150
// });

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
