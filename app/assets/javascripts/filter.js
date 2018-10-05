/**
 * Get filter values for workers view.
 */
function getFilters(filterType) {
    var filters = {};

    // Collect IDs for checking filter contents from the page.
    var idPrefix = "";
    var textFilters = [];
    var checkboxFilters = [];
    if (filterType == "spray_data") {
        idPrefix = "#data_filter_";
        textFilters = ["timestamp", "foreman", "sprayers", "latitude", "longitude"];

    } else if (filterType == "future_spray_locations") {
        idPrefix = "#location_filter_";
        textFilters = ["report_date", "reporter", "latitude", "longitude"];

    } else if (filterType == "malaria_reports") {
        idPrefix = "#report_filter_";
        textFilters = ["report_date", "reporter", "latitude", "longitude"];

    } else if (filterType == "workers") {
        idPrefix = "#worker_filter_";
        textFilters = ["name", "worker_id"];
        checkboxFilters = ["active"];
    }

    // Add text filters into filters variable.
    if (textFilters.length > 0) {
        textFilters.forEach(function(filter) {
            filters[filter] = getTextFieldValue(idPrefix + filter);
        });
    }

    // Add checkbox filters into filters variable.
    if (checkboxFilters.length > 0) {
        checkboxFilters.forEach(function(filter) {
            filters[filter] = getCheckBoxValue(idPrefix + filter);
        });
    }

    // Check if we have any meaningful filters at all.
    var hasFilters = false;
    for (var key in filters) {
        hasFilters = filters[key] != "" && filters[key] != false;
        if (hasFilters)
            break;
    }
    return [filters, hasFilters];
}

/**
 * Update URL based on filter values for workers view.
 */
function updateURLForFilters(link, filters, hasFilters) {
    // Sanitize from escaped characters.
    link = link.replace(new RegExp("%5B", 'g'), "[");
    link = link.replace(new RegExp("%5D", 'g'), "[");

    // Remove old filter params.
    restAPIFilter = "filter\\[[^\\]]*\\]=[^&]*";
    while (new RegExp(restAPIFilter).test(link)) {
        ["&", "\\?"].forEach(function(previousChar) {
            link = link.replace(new RegExp(previousChar + restAPIFilter + "&"), previousChar);
            link = link.replace(new RegExp(previousChar + restAPIFilter + "$"), "");
        });
    }
    link = link.replace(/\/\?/, "?");
    link = link.replace(/\/$/, "");
    link = link.replace(/\?$/, "");

    // Add new filter params.
    if (hasFilters) {
        for (var key in filters) {
            if (filters[key] != "" && filters[key] != false && typeof filters[key] != 'undefined') {
                if (!/\?/.test(link))
                    link += "?";
                else
                    link += "&";

                var value = ""
                if (key == "active")
                    value = "true";
                else
                    value = filters[key].replace(new RegExp("&", 'g'), "%26");
                link += "filter[" + key + "]=" + value;
            }
        }
    }
    return link;
}

/**
 * Update displayed info based on filters for workers view.
 */
function filter(filterType) {
    // Get filter values.
    filterInfo = getFilters(filterType);
    filters = filterInfo[0];
    hasFilters = filterInfo[1];

    // Get class keyword for filtering HTML.
    filterTypeArray = filterType.split("_");
    contentType = filterTypeArray[filterTypeArray.length - 1];
    contentType = contentType.replace(/s$/, "");

    // Decide if each row should be filtered or not.
    $(".data-row").each(function() {
        var row = this;
        var displayMode = "table-row";
        Object.keys(filters).forEach(function(filter) {
            if (filters[filter] != "" && filters[filter] != false) {
                var colVal = $.trim($(row).find("." + contentType + "_" + filter).html());
                colVal = colVal.replace(/&amp;/g, "&");
                colVal = colVal.replace(/\n/g, "");
                colVal = colVal.replace(/<br>/g, "");
                var filterRegex = new RegExp("^(.*[ /])?" + filters[filter], "i");
                if (filter == "active")
                    filterRegex = new RegExp("^true", "i")
                if (!filterRegex.test(colVal))
                    displayMode = "none";
            }
        });

        $(row).css("display", displayMode);
    });

    // Update sorting links' REST API params.
    $(".sort-header").each(function() {
        currentURL = $(this).attr("href");
        $(this).attr("href", updateURLForFilters(currentURL, filters, hasFilters));
    });

    // Update URL's REST API params.
    var newUrl = updateURLForFilters(window.location.href, filters, hasFilters)
    history.replaceState({ turbolinks: true, url: newUrl }, "", newUrl)
}

/**
 * Make listeners on all form elements for a page with filtering available
 */
function loadJSForFilters(filterType) {
    url = getRoute();
    if (url == (filterType + "/view")) {
        $(".filter-field").each(function() {
            $(this).bind("keyup input paste", function() { filter(filterType); });
        });
        $(".filter-field-dropdown").change(function() { filter(filterType); });
        $(".filter-field-checkbox").change(function() { filter(filterType); });

        filter(filterType);

    }
}

$(document).on('turbolinks:load', function() { loadJSForFilters("workers"); });
$(document).on('turbolinks:load', function() { loadJSForFilters("spray_data"); });
$(document).on('turbolinks:load', function() { loadJSForFilters("malaria_reports"); });
$(document).on('turbolinks:load', function() { loadJSForFilters("future_spray_locations"); });
