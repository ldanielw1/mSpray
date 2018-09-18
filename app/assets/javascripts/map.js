var defaultMode = "default";
var addFutureSprayLocations = "add-future-spray-locations";
var addMalariaReports = "add-malaria-reports"
var mapMode = defaultMode;

function initMap() {
    // Create the new map.
    var mapSettings = {
        zoom: 8,
        center: new google.maps.LatLng(-23.151, 30.658),
        zoomControlOptions: {
            position: google.maps.ControlPosition.LEFT_BOTTOM
        },
        streetViewControlOptions: {
            position: google.maps.ControlPosition.LEFT_BOTTOM
        }
    };

    var mapDiv = document.getElementById('map');
    var map = new google.maps.Map(mapDiv, mapSettings);
    var infowindow = new google.maps.InfoWindow({ content: '' });

    // Create an array of new markers.
    function createMarker(markerType) {
        var sd = gon.data[markerType][i];
        var dataLat = sd["lat"];
        var dataLng = sd["lng"];

        var markerColor = "blue";
        if (markerType == "future_spray_locations")
            markerColor = "yellow";
        else if (markerType == "malaria_reports")
            markerColor = "red";
        var marker = new google.maps.Marker({
            position: { lat: dataLat, lng: dataLng },
            map: map,
            icon: "../assets/marker_" + markerColor + ".png"
        });

        var contentString = "";
        if (markerType == "spray_data") {
            contentString += "<h4>Spray Data</h4>";
        } else if (markerType == "future_spray_locations") {
            contentString += "<h4>Future Spray Location</h4>";
            contentString += "<strong>Reporter: </strong>" + sd["reporter"] + "<br>";
            contentString += "<strong>Date: </strong>" + sd["report_time"] + "<br>";
        } else if (markerType == "malaria_reports") {
            contentString += "<h4>Malaria Report Location</h4>";
            contentString += "<strong>Reporter: </strong>" + sd["reporter"] + "<br>";
            contentString += "<strong>Date: </strong>" + sd["report_time"] + "<br>";
        }

        contentString += "<strong>LatLng: </strong>" + dataLat.toString() + ', ' + dataLng.toString();
        contentString = '<div>' + contentString + '</div>';

        marker.addListener('click', function() {
            infowindow.setContent(contentString);
            infowindow.open(map, marker);
        });

        return marker;
    }

    var dataMarkers = new Array();
    var futureMarkers = new Array();
    var malariaReportMarkers = new Array();

    for (var i = 0; i < gon.data["spray_data"].length; i++)
        dataMarkers.push(createMarker("spray_data"));
    for (var i = 0; i < gon.data["future_spray_locations"].length; i++)
        futureMarkers.push(createMarker("future_spray_locations"));
    for (var i = 0; i < gon.data["malaria_reports"].length; i++)
        malariaReportMarkers.push(createMarker("malaria_reports"));

    // Add clustering for markers.
    var markerCluster = new MarkerClusterer(map, dataMarkers, { imagePath: "../assets/m" });
    var markerCluster = new MarkerClusterer(map, futureMarkers, { imagePath: "../assets/m" });
    var markerCluster = new MarkerClusterer(map, malariaReportMarkers, { imagePath: "../assets/m" });

    // Add the on-click and mouseover listeners
    google.maps.event.addListener(map, "click", function(e) { clickMap(e); });
    google.maps.event.addListener(map, "mouseover", function(e) { hoverMap(map) })
}

/**
 * Interact with the map when it's clicked on.
 */
function clickMap(e) {
    var latLng = e.latLng;
    var lat = latLng.lat();
    var lng = latLng.lng();
    var email = $(".nav_email").html();

    var currentDate = new Date();
    var yearMonthDay = currentDate.getFullYear() + "/" + currentDate.getMonth() + "/" + currentDate.getDate();

    if (mapMode == addFutureSprayLocations) {

        // Send lat, lng, and user email to controller
        var target = "dashboard/add_future_spray_location";
        window.location.href = target + "?lat=" + lat + "&lng=" + lng + "&reporter=" + email + "&dateTime=" + yearMonthDay;
    } else if (mapMode == addMalariaReports) {

        // Send lat, lng, and user email to controller
        var target = "dashboard/add_malaria_report";
        window.location.href = target + "?lat=" + lat + "&lng=" + lng + "&reporter=" + email + "&dateTime=" + yearMonthDay;
    } else {
        if (!$(e.target).closest("#map-add-button, #collapse-add-options").length) {
            if ($("#collapse-add-options").is(":visible"))
                $("#map-add-button").click();
        }
    }
}

function hoverMap(map) {
    var defaultDragCursor = 'url("https://maps.gstatic.com/mapfiles/openhand_8_8.cur"), default';
    var markerColor;

    if(mapMode != defaultMode) { 
        if (mapMode == addFutureSprayLocations) {
            markerColor = "yellow";
        } else if (mapMode == addMalariaReports) {
            markerColor = "red";
        }
        map.setOptions({draggableCursor: markerCursor(markerColor)});
    } else {
        map.setOptions({draggableCursor: defaultDragCursor});
    }
}

function markerCursor(markerColor) {
    return "url(../assets/marker_" + markerColor + ".png) 13.5 43, default"
}

/**
 * Interact with the map when it's clicked on.
 */
function toggleAddButton(e) {
    mapMode = "default";
    mapButton = $("#map-add-button");
    mapText = mapButton.find(".fas");
    arrow = "fa-arrow-circle-right";
    plus = "fa-plus";

    if (mapButton.html().toString().indexOf("fa-plus") > -1) {
        mapText.addClass(arrow).removeClass(plus);
    } else {
        mapText.addClass(plus).removeClass(arrow);
    }

    setModeDefault()

}

/**
 * takes in the mapMode, defined in this JS file
 */
function toggleSelectedButton(mode) {
    toggleMode(mode);

    var modeClass = ".toggle-" + mode;
    var isActive = $(modeClass).hasClass("active");
    turnOffActiveFromAll();
    if (!isActive)
        $(modeClass + ".button-overlay").addClass("active");
}

function toggleMode(mode) {
    if (mapMode == mode) {
        mapMode = defaultMode;
    } else {
        mapMode = mode;
    }
}

function turnOffActiveFromAll() {
    $(".menu-option").removeClass("active");
}

function setModeDefault() {
    turnOffActiveFromAll();
    mapMode = defaultMode;
}

function toggleMapPointer() {
    $("#map").attr("style", "cursor: pointer");
}

/**
 * Make listeners on all form elements for data view
 */
function loadJSForInitMap() {
    url = getRoute();
    if (url == "") {
        if (window.google) {
            initMap();
        } else {
            $.ajax('https://maps.googleapis.com/maps/api/js?key=AIzaSyCZYMGmb59cC8ewA4j5YgekHf4HmnCV3uM&callback=initMap', {
                crossDomain: true,
                dataType: 'script'
            });
        }

        $("#map-add-button").click(function() { toggleAddButton() });
        $(".toggle-add-future-spray-locations").click(function() { toggleSelectedButton(addFutureSprayLocations) });
        $(".toggle-add-malaria-reports").click(function() { toggleSelectedButton(addMalariaReports) });
    }
}

$(document).on('turbolinks:load', loadJSForInitMap);
