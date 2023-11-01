// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// フォーム送信前に確認ダイアログを表示
document.addEventListener('turbolinks:load', function() {
  const withdrawalForm = document.querySelector('#withdrawal-form');

  if (withdrawalForm) {
    withdrawalForm.addEventListener('submit', function(e) {
      if (!confirm('本当に消しますか？')) {
        e.preventDefault(); // フォーム送信をキャンセル
      }
    });
  }
});