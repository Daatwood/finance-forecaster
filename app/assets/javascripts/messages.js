var ready;
ready = function() {
  $('.btn-form').click(function(){
    $button = $('.btn-form')
    $form = $('.form-btn');
    $form.toggle();
    if ($form.is(":visible") )
      $button.html("Hide")
    else
      $button.html("Add New")
    $button.toggleClass("btn-danger");
  });
  $('#hide-canvas').click(function(){
    $button = $('#hide-canvas')
    $target = $('#canvas');
    $target.toggle();
    if ($target.is(":visible") ){
      $button.html("Hide Chart")
    } else {
      $button.html("Show Chart")
    }
  });
  $('td.hide_on_click').click( function(){
    $(this).parent('tr').hide();
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
