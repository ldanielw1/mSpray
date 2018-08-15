// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require turbolinks

/**
 * Returns a standard ID for a filter object
 */
function getFilterId(filter) {
    return "#data_filter_" + filter;
}

/**
 * Gets whether a checkbox is selected or not
 */
function getCheckBoxValue(filter) {
    return $(filter).is(':checked');
}

/**
 * Gets selected option's text from a dropdown selector
 */
function getDropdownText(filter) {
    return $(filter + " option:selected").text();
}

/**
 * Gets selected option from a dropdown selector
 */
function getDropdownValue(filter) {
    return $(filter + " option:selected").val();
}

/**
 * Gets text typed out in a text field
 */
function getTextFieldValue(filter) {
    return $(filter).val();
}

/**
 * Gets current URL route
 */
function getRoute() {
    var baseUrlPattern = /^https?:\/\/[a-z\:0-9.]+/;
    var match = baseUrlPattern.exec(location.href);
    if (match != null) {
        var result = match[0];
        if (result.length > 0)
            url = location.href.replace(result, "");
    }
    url = url.replace(/^\//, "");
    url = url.replace(/\/$/, "");
    url = url.replace(/\/\?/, "?");
    url = url.split("?")[0];

    return url;
}

/**
 * Fades the currently displayed flash message after some time
 */
$(document).on('turbolinks:load', function() {
    var closeNotice = setInterval(function() {
    	if ($('.fadeIn').length == 0) {
    		clearInterval(closeNotice);
    	}
    	$('.notice').removeClass('fadeIn').addClass('fadeOut');
    }, 6000);
});
