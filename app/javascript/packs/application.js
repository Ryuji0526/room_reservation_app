// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function() {
  const userIcon = document.getElementById('user-icon');
  const dropdown = document.getElementById('dropdown');
  const roomSearch = document.getElementById('room_search');
  const searchBoxes = document.querySelectorAll('#room_search > input')
  
  userIcon.addEventListener('click', () => {
    dropdown.classList.toggle('hidden-menu');
  });
  
  window.addEventListener('submit', () => {
    searchBoxes.forEach(searchBox => {
      searchBox.textContent = "";
    });
  });
});

