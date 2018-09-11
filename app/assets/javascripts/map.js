var mapMode = "default";
var addFutureSprayLocations = "add-future-spray-locations";

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

        var markerColor = "red";
        if (markerType == "future_spray_locations")
            markerColor = "blue";
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
    for(var i = 0; i < gon.data["spray_data"].length; i++)
        dataMarkers.push(createMarker("spray_data"));
    for(var i = 0; i < gon.data["future_spray_locations"].length; i++)
        futureMarkers.push(createMarker("future_spray_locations"));

    // Add clustering for markers.
    var markerCluster = new MarkerClusterer(map, dataMarkers, {imagePath: "../assets/m"});
    var markerCluster = new MarkerClusterer(map, futureMarkers, {imagePath: "../assets/m"});

    // Add the on-click listener
    google.maps.event.addListener(map, "click", function (e) { clickMap(e); });
}

/**
 * Interact with the map when it's clicked on.
 */
function clickMap(e) {
    if (mapMode == addFutureSprayLocations) {
        // Get lat, lng from event
        var latLng = e.latLng;
        var lat = latLng.lat();
        var lng = latLng.lng();

        // Send lat, lng, and user email to controller
        var target = "dashboard/add_future_spray_location";
        var email = $(".nav_email").html();
        window.location.href = target + "?lat=" + lat + "&lng=" + lng + "&reporter=" + email;
    }
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

        $("#map-add-button").click(function() { mapMode = "default"; });
        $(".toggle-add-future-locations").click(function() { mapMode = addFutureSprayLocations; });
    }
}

function toggleSymbol() {
  var btn = document.getElementById("form-button");
    if (btn.innerHTML=="+") btn.innerHTML = ">";
    else btn.innerHTML = "+";
}

$(document).on('turbolinks:load', loadJSForInitMap);
