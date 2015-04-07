var ready;
ready = function() {
  $('.btn-form').click(function(){
    $button = $('.btn-form')
    $form = $('.form-btn');
    $form.toggle();
    if ($form.is(":visible") ){
      $button.html("Hide")
      $button.toggleClass("btn-danger");
    } else {
      $button.html("Add New")
      $button.toggleClass("btn-danger");
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
