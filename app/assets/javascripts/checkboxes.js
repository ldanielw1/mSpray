function updateCheckboxBackend(checkbox) {
  var target = "#" + checkbox.attr("for");
  var isChecked = checkbox.is(":checked");
  var newValue = 0;
  if (isChecked)
    newValue = 1;

  // Toggle hidden ROR display checkbox
  $(target).attr("value", newValue);

  // Toggle hidden real checkbox
  $(target).prev().attr("value", newValue);
}

function loadCheckboxes() {
  // Checkbox backend should be initialized properly
  $(".checkbox-trigger").each(function() {
    updateCheckboxBackend($(this));
  });

  // Listen for changes and update backend when front end is changed
  $('.checkbox-trigger').change(function() {
    updateCheckboxBackend($(this));
  });
}

$(document).on('turbolinks:load', loadCheckboxes);
