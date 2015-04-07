var ready;
ready = function() {
  jQuery(".best_in_place").best_in_place();
  jQuery('.minicolors').minicolors();
};

$(document).ready(ready);
$(document).on('page:load', ready);
