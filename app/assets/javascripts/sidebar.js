/**
 * Find out whether or not a certain menu item ought to be highlighted as active
 */
function sidebar_item_class(menu_item) {
    url = getRoute();
    page_category = "";
    if (url == "" || url == "#")
        page_category = "dashboard";
    else if (/^spray_data/.test(url))
        page_category = "spray_data";
    else if (/^workers/.test(url))
        page_category = "workers";
    else if (/^admin/.test(url)) // all courses and users pages are admin pages unless indicated otherwise earlier
        page_category = "admin";

    if (menu_item == page_category)
        return "nav_item-active";
    return "";
}

/**
 * Set listeners for all of the menu items on page load
 */
function sidebar_set_highlights() {
    $(".sidebar_item").each(function(index, child) {
        sidebar_item_classes = $(child).attr('class');
        sidebar_item_category = sidebar_item_classes.split(" ")[1];
        new_class = sidebar_item_class(sidebar_item_category);
        if (new_class != "")
            $(child).addClass(new_class);
    });
}

$(document).on('turbolinks:load', sidebar_set_highlights);
