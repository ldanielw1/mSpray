/**
 * Clicking anywhere in each sidebar item should take us from page to page (instead of only when clicking link text).
 */
function loadSidebarLinks() {
  $(".sidebar__link").click(function() {
    var link = $(this).find("a").attr("href");
    window.location.href = link;
  });
}


$(document).on('turbolinks:load', loadSidebarLinks);
