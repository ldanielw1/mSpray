function signOutButtons() {
  $('.dropdown-trigger').dropdown({
    alignment: 'right'
  });
}

$(document).on('turbolinks:load', signOutButtons);
