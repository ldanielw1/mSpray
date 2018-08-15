function initMap() {
    var mapSettings = {
        zoom: 8,
        center: new google.maps.LatLng(-23.401, 29.418)
    };
    
    var mapDiv = document.getElementById('map');
    var map = new google.maps.Map(mapDiv, mapSettings);

    var marker = new google.maps.Marker({
        position: {lat: -22.878, lng: 30.728},
        map: map
    });
}