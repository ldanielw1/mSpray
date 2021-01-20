function loadFloatingActionButtons() {
  $('.fixed-action-btn').floatingActionButton({ hoverEnabled: false });
  $('.collapsible').collapsible();
  
  $('.btn-large.red').hover(function() { $(this).addClass("lighten-2"); },
                            function() { $(this).removeClass("lighten-2"); });
}

$(document).on('turbolinks:load', loadFloatingActionButtons);
