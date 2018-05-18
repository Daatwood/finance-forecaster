var buttonMagic = function() {
  $(".btn-form").on("click", function() {
    $button = $(".btn-form");
    $form = $(".form-btn");
    $form.toggle();
    if ($form.is(":visible")) {
      $button.prop("original-text", $button.html());
      $button.html("Hide");
    } else $button.html($button.prop("original-text"));
    $button.toggleClass("btn-danger");
  });
  $("#new-transaction-button").click(function() {
    $button = $("#new-transaction-button");
    $form = $("#new-transaction-form");
    $form.toggle();
    if ($form.is(":visible")) {
      $button.html("Cancel");
    } else {
      $button.html("Add Transaction");
    }
  });
  $("#new-recurrence-button").click(function() {
    $button = $("#new-recurrence-button");
    $form = $("#new-recurrence-form");
    $form.toggle();
    if ($form.is(":visible")) {
      $button.html("Cancel");
    } else {
      $button.html("Add Recurrence");
    }
  });
  $("#new-exception-button").click(function() {
    $button = $("#new-exception-button");
    $form = $("#new-exception-form");
    $form.toggle();
    if ($form.is(":visible")) {
      $button.html("Cancel");
    } else {
      $button.html("Add Exception");
    }
  });
  $("#readjustment-button").click(function() {
    $balance = $(".balance-text");
    $button = $("#readjustment-button");
    $form = $("#readjustment-form");
    if ($form.length === 1) {
      $form.toggleClass("hide");
      if ($form.is(":visible")) {
        $button.prop("original-text", $button.html());
        $button.html("Cancel");
        $balance.hide();
      } else {
        $button.html($button.prop("original-text"));
        $balance.show();
      }
      $button.toggleClass("btn-danger");
    }
  });
};

$(document).ready(buttonMagic);
$(document).on("page:load", buttonMagic);
