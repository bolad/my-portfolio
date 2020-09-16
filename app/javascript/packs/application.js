// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
import 'cocoon-js'
import "controllers"

import '../stylesheets/application.scss'

require("trix")
require("@rails/actiontext")
require("gritter/js/jquery.gritter.js")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery-ui-dist/jquery-ui");
require("html.sortable")
require("jquery")

global.$ = jQuery;

var ready, set_positions;

ready = void 0;

set_positions = void 0;

set_positions = function() {
  $('.card').each(function(i) {
    $(this).attr('data-pos', i + 1);
  });
};

ready = function() {
  set_positions();
  $('.sortable').sortable();
  $('.sortable').sortable().bind('sortupdate', function(e, ui) {
    var updated_order;
    updated_order = [];
    set_positions();
    $('.card').each(function(i) {
      updated_order.push({
        id: $(this).data('id'),
        position: i + 1
      });
    });
    $.ajax({
      type: 'PUT',
      url: '/portfolios/sort',
      data: {
        order: updated_order
      }
    });
  });
};

$(document).ready(ready);


