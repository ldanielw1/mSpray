function initMap() {
    // Create the new map.
    var mapSettings = {
        zoom: 8,
        center: new google.maps.LatLng(-23.151, 30.658)
    };
    var mapDiv = document.getElementById('map');
    var map = new google.maps.Map(mapDiv, mapSettings);
    var infowindow = new google.maps.InfoWindow({ content: '' });

    // Create an array of new markers.
    function createMarker() {
        var marker = new google.maps.Marker({
            position: {lat: gon.data[i]["lat"], lng: gon.data[i]["lon"]},
            map: map
        });

        var contentString = gon.data[i]["lat"].toString();
        contentString += ', ' + gon.data[i]["lon"].toString();
        contentString = '<div>' + contentString + '</div>';

        marker.addListener('click', function() {
            infowindow.setContent(contentString);
            infowindow.open(map, marker);
        });

        return marker;
    }

    var markers = new Array();
    for(var i = 0; i < gon.data.length; i++)
        markers.push(createMarker());

    // Add clustering for markers.
    var markerCluster = new MarkerClusterer(map, markers, {imagePath: "../assets/m"});
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
    }
}

$(document).on('turbolinks:load', loadJSForInitMap);
