function initMap() {
    var mapSettings = {
        zoom: 8,
        center: new google.maps.LatLng(-23.151, 30.658)
    };
    
    var mapDiv = document.getElementById('map');
    var map = new google.maps.Map(mapDiv, mapSettings);
    var infowindow = new google.maps.InfoWindow({
        content: '' 
    });
 
    function createMarker()
    {
        var marker = new google.maps.Marker({
            position: {lat: gon.data[i]["lat"], lng: gon.data[i]["lon"]},
            map: map
        });

        var contentString = '<div>' + gon.data[i]["lat"].toString() + ', ' + 
            gon.data[i]["lon"].toString() + '</div>';

        marker.addListener('click', function() {
            infowindow.setContent(contentString);
            infowindow.open(map, marker);
        });

        return marker;
    }

    var markers = new Array();

    for(var i = 0; i < gon.data.length; i++)
    {
        markers.push(createMarker());
    }

    var markerCluster = new MarkerClusterer(map, markers, {imagePath: "../assets/m"});
}