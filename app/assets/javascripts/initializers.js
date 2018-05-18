var ready;
ready = function() {
  $(".best_in_place").best_in_place();
  $(".minicolors").minicolors();
};

$(document).ready(ready);
$(document).on("page:load", ready);
