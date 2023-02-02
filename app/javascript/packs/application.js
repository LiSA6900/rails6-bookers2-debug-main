// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks" ※Turbolinksの無効化
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "popper.js"
import "bootstrap"
import '@fortawesome/fontawesome-free/js/all';
import "../stylesheets/application" 

Rails.start()
// Turbolinks.start() ※Turbolinksの無効化
ActiveStorage.start()
