/**
 * Get filter values for data view
 */
function getFiltersForFilteringData() {
    var filters = {};
    var id_prefix = "#data_filter_";
    ["timestamp", "sprayer_1", "sprayer_2", "latitude", "longitude"].forEach(function(filter) {
        filters[filter] = getTextFieldValue(id_prefix + filter);
    });
    [].forEach(function(filter) {
        filters[filter] = getDropdownText(id_prefix + filter);
    });

    var hasFilters = false;
    for (var key in filters) {
        hasFilters = filters[key] != "" && filters[key] != false;
        if (hasFilters)
            break;
    }

    return [filters, hasFilters];
}

/**
 * Update URL based on filter values for data view
 */
function updateURLForFilteringData(link) {
    filterInfo = getFiltersForFilteringData();
    filters = filterInfo[0];
    hasFilters = filterInfo[1];

    // Sanitize from escaped characters
    link = link.replace(new RegExp("%5B", 'g'), "[");
    link = link.replace(new RegExp("%5D", 'g'), "[");

    // Remove old filter params
    rest_api_filter = "filter\\[[^\\]]*\\]=[^&]*";
    while (new RegExp(rest_api_filter).test(link)) {
        ["&", "\\?"].forEach(function(previousChar) {
            link = link.replace(new RegExp(previousChar + rest_api_filter + "&"), previousChar);
            link = link.replace(new RegExp(previousChar + rest_api_filter + "$"), "");
        });
    }
    link = link.replace(/\/\?/, "?");
    link = link.replace(/\/$/, "");
    link = link.replace(/\?$/, "");

    // Add new filter params
    if (hasFilters) {
        for (var key in filters) {
            if (filters[key] != "" && filters[key] != false && typeof filters[key] != 'undefined') {
                if (!/\?/.test(link))
                    link += "?";
                else
                    link += "&";

                var value = filters[key].replace(new RegExp("&", 'g'), "%26");
                link += "filter[" + key + "]=" + value;
            }
        }
    }
    return link;
}

/**
 * Update displayed info based on filters for data view
 */
function updateFiltersForFilteringData() {
    filterInfo = getFiltersForFilteringData();
    filters = filterInfo[0];
    hasFilters = filterInfo[1];

    // Decide if each row should be filtered or not
    $(".data-row").each(function() {
        var row = this;
        var displayMode = "table-row";
        Object.keys(filters).forEach(function(filter) {
            if (filters[filter] != "" && filters[filter] != false) {
                var col_val = $.trim($(row).find(".data_" + filter).html());
                col_val = col_val.replace(/&amp;/g, "&");
                col_val = col_val.replace(/\n/g, "");
                col_val = col_val.replace(/<br>/g, "");
                var filter_regex = new RegExp("^(.*[ /])?" + filters[filter], "i");
                if (!filter_regex.test(col_val))
                    displayMode = "none";
            }
        });

        $(row).css("display", displayMode);
    });

    // Update sorting links' REST API params
    $(".sort-header").each(function() {
        current_url = $(this).attr("href");
        $(this).attr("href", updateURLForFilteringData(current_url));
    });

    // Update URL's REST API params
    history.pushState({}, null, updateURLForFilteringData(window.location.href));
}

/**
 * Make listeners on all form elements for data view
 */
function loadJSForFilteringData() {
    url = getRoute();
    if (url == "data/view") {
        $(".filter-field").each(function() {
            $(this).bind("keyup input paste", function() { updateFiltersForFilteringData(); });
        });
        $(".filter-field-dropdown").change(function() { updateFiltersForFilteringData(); });

        updateFiltersForFilteringData();
    }
}

$(document).on('turbolinks:load', loadJSForFilteringData);
