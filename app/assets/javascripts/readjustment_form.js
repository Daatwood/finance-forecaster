$(document).ready(function(){
  $('#readjustment-button').click(function(){
    $balance = $('.balance-text')
    $button = $('#readjustment-button')
    $form = $('#readjustment-form')
    if ($form.length != 0){
      $form.toggle();
      if ($form.is(":visible") ){
        $button.prop('original-text', $button.html())
        $button.html("Cancel")
        $balance.hide()
      } else {
        $button.html($button.prop('original-text'))
        $balance.show()
      }
      $button.toggleClass("btn-danger");
    }
  });
});