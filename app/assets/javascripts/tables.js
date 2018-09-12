/**
 * Handle opening the delete spray datum modal
 */
function handleOpeningSprayDatumModal(object, e, mode) {
    var modal = $(object).parent().find("." + mode + "_spray_datum_modal");
    modal.modal("toggle");
    e.stopPropagation();
}

/**
 * Handle closing the delete spray datum modal
 */
function handleClosingSprayDatumModal(e, mode) {
    var target = $(e.target);
    e.stopPropagation();
}

/**
 * Make sure clicking on the delete button for spray data doesn't affect row expansion/collapse.
 */
function loadJSForDeletingSprayData() {
    url = getRoute();
    if (url == "spray_data/view") {
        $(".edit_spray_datum").click(function (e) {
            handleOpeningSprayDatumModal(this, e, "edit");
        });
        $(".edit_spray_datum_modal").click(function (e) {
            handleClosingSprayDatumModal(e, "edit");
        });
        $(".delete_spray_datum").click(function (e) {
            handleOpeningSprayDatumModal(this, e, "delete");
        });
        $(".delete_spray_datum_modal").click(function (e) {
            handleClosingSprayDatumModal(e, "delete");
        });
    }
}

$(document).on('turbolinks:load', loadJSForDeletingSprayData);
