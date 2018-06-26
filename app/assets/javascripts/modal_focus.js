/**
 * Focus the submit button on all modals when pulled up. No need to focus anything on modal close - it will refocuson trigger button by default.
 */
$(window).on('shown.bs.modal', function(evt) { 
    modalButton = $(evt.relatedTarget);
    modal = $(modalButton.attr("data-target"));
    default_button = modal.find(".modal-default")
    default_button.focus();
});
