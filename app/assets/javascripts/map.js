var defaultMode = "default";
var addFutureSprayLocations = "add-future-spray-locations";
var addMalariaReports = "add-malaria-reports";
var addSprayData = "add-spray-data";
var mapMode = defaultMode;

function createGoogleMapUrl(lat, lng) {
  return "https://www.google.com/maps/search/?api=1&query=" + lat + "," + lng;
}

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
    },
    clickableIcons: false
  };

  var mapDiv = document.getElementById('map');
  var map = new google.maps.Map(mapDiv, mapSettings);
  map.setOptions({ minZoom: 7 })

  var allowedBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(-36.51369800826651, 10.712649477748528),
    new google.maps.LatLng(-18.796702001128146, 42.13354791524853)
  );
  var infowindow = new google.maps.InfoWindow({ content: '' });

  //boundaries NE: (-18.796702001128146, 42.13354791524853) SW: (-36.51369800826651, 10.712649477748528)

  // Create an array of new markers.
  function createMarker(markerType) {
    var sd = gon.data[markerType][i];

    // Extract data lat and lng from gon
    var dataLat = sd["lat"];
    var dataLng = sd["lng"];
    var map_url = createGoogleMapUrl(dataLat.toString(), dataLng.toString());

    // Create marker, define marker color
    var markerColor = "blue";
    if (markerType == "future_spray_locations")
      markerColor = "yellow";
    else if (markerType == "malaria_reports")
      markerColor = "red";
    else if (markerType == "spray_data")
      markerColor = "blue";
    var marker = new google.maps.Marker({
      position: { lat: dataLat, lng: dataLng },
      map: map,
      draggable: true,
      icon: "../assets/marker_" + markerColor + ".png"
    });

    // Create variables for use in contentString, particularly for deletion
    var title = markerType.split("_").map(word => word[0].toUpperCase() + word.substr(1)).join(" ");
    var deleteTarget = "delete_" + markerType;
    var deleteUrl = markerType + "/delete?id=" + sd["id"];
    var deleteType = title.split(' ').join('');
    var deleteButtonId = deleteTarget + "_button_" + sd["id"];

    // contentString creation
    var contentString = "<div id=\"" + markerType + "_" + sd["id"] + "\">";
    contentString += "<h4>" + title + "</h4>";
    if (markerType != "spray_data") {
      contentString += "<strong>Reporter: </strong><span class=\"reporter\">" + sd["reporter"] + "</span></strong><br>";
      contentString += "<strong>Date: </strong><span class=\"report_date\">" + sd["report_date"] + "</span></strong><br>";
    }
    contentString += "<strong>LatLng: </strong>" + dataLat.toString() + ", " + dataLng.toString() + "<br>";
    contentString += "<a href=" + map_url + " target='_blank'>See In Google Maps</a>";
    contentString += "<br>";
    contentString += "<button id=" + deleteButtonId + " class=\"btn modal-trigger delete_marker\" data-target=\"delete_pin\" onclick=\"setDeleteModalFormInfo('" + markerType + "', " + sd["id"] + ")\">Delete Marker</button>";
    contentString += "</div>"

    // Add listener to display contentString on clicking on the marker
    marker.addListener('click', function() {
      infowindow.setContent(contentString);
      infowindow.open(map, marker);
    });

    // moving marker listener
    marker.addListener('dragend', function() {
      var markerPosition = marker.getPosition();
      setEditModalFormInfo(markerType, sd["id"], markerPosition.lat(), markerPosition.lng());
      $("#move_pin").modal('open');
      $("#cancel_move").on('click', function() {
        marker.setPosition({lat: dataLat, lng: dataLng});
      });
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
  google.maps.event.addListener(map, "mouseover", function(e) { hoverMap(map) });
  google.maps.event.addListener(map, "center_changed", function(e) { checkBounds(map, allowedBounds) });
}

/**
 * Interact with the map when it's clicked on.
 */
function clickMap(e) {
  var latLng = e.latLng;
  var lat = latLng.lat();
  var lng = latLng.lng();
  var username = $(".profile__name").html();
  var email = $(".profile__email").html();

  var currentDate = new Date();
  var reportDate = currentDate.getMonth() + "/" + currentDate.getDate() + "/" + currentDate.getFullYear();

  if (mapMode == addFutureSprayLocations || mapMode == addMalariaReports) {
    // Send lat, lng, and user email to add_pin_modal
    setAddModalFormInfo(mapMode, lat, lng, username, email, reportDate)
    $("#add_pin").modal('open');
  } else if (mapMode == addSprayData) {
    reportDate = currentDate.getFullYear() + "-" 
      + (currentDate.getDate() < 10 ? "0" : "") + currentDate.getDate() + "-"
      + (currentDate.getMonth() + 1 < 10 ? "0" : "") + (currentDate.getMonth() + 1) + " "
      + (currentDate.getHours() < 10 ? "0" : "") + currentDate.getHours() + ":"
      + (currentDate.getMinutes() < 10 ? "0" : "") + currentDate.getMinutes() + ":"
      + (currentDate.getSeconds() < 10 ? "0" : "") + currentDate.getSeconds();
    setDataModalFormInfo(mapMode, lat, lng, username, email, reportDate)
    $("#add_data").modal('open');
  } else {
    if ($(".fixed-action-btn").hasClass("active")) {
      $(".fixed-action-btn").click();
    }
  }
}

function hoverMap(map) {
  var defaultDragCursor = 'url("https://maps.gstatic.com/mapfiles/openhand_8_8.cur"), default';
  var markerColor;

  if (mapMode != defaultMode) {
    if (mapMode == addFutureSprayLocations) {
      markerColor = "yellow";
    } else if (mapMode == addMalariaReports) {
      markerColor = "red";
    } else if (mapMode == addSprayData) {
      markerColor = "blue";
    }
    map.setOptions({ draggableCursor: markerCursor(markerColor) });
  } else {
    map.setOptions({ draggableCursor: defaultDragCursor });
  }
}

function mapFloorThousandth(num) {
  intNum = Math.floor(num * 1000);
  return intNum / 1000;
}

function mapCeilThousandth(num) {
  intNum = Math.ceil(num * 1000);
  return intNum / 1000;
}

function checkBounds(map, allowedBounds) {

  // Get current viewport stats
  var mapBounds = map.getBounds();
  var mapHeight = mapBounds.getNorthEast().lat() - mapBounds.getSouthWest().lat();
  var mapLength = mapBounds.getNorthEast().lng() - mapBounds.getSouthWest().lng();
  var mapNE = mapBounds.getNorthEast();
  var mapSW = mapBounds.getSouthWest();

  // Get allowed viewport stats
  var allowedNE = allowedBounds.getNorthEast();
  var allowedSW = allowedBounds.getSouthWest();
  var maxLng = mapFloorThousandth(allowedNE.lng() - (mapLength / 2));
  var maxLat = mapFloorThousandth(allowedNE.lat() - (mapHeight / 2));
  var minLng = mapCeilThousandth(allowedSW.lng() + (mapLength / 2));
  var minLat = mapCeilThousandth(allowedSW.lat() + (mapHeight / 2));

  var c = map.getCenter();
  var lng = c.lng();
  var lat = c.lat();

  // Only shift the map if it's out of bounds
  if (lng < minLng || lng > maxLng || lat < minLat || lat > maxLat) {
    var spacing = 0.02;
    if (lng < minLng)
      lng = minLng + spacing;
    else if (lng > maxLng)
      lng = maxLng - spacing;
    if (lat < minLat)
      lat = minLat + spacing;
    else if (lat > maxLat)
      lat = maxLat + spacing;

    console.log("\nout of bounds");
    console.log(lat + ", " + lng);
    map.panTo(new google.maps.LatLng(lat, lng));

  }
}

function markerCursor(markerColor) {
  return "url(../assets/marker_" + markerColor + ".png) 13.5 43, default"
}

/**
 * takes in the mapMode, defined in this JS file
 */
function toggleSelectedButton(mode) {
  toggleMode(mode);

  var modeClass = ".toggle-" + mode;
  var isActive = $(modeClass).hasClass("active");
  turnOffActiveFromAll();
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

function setAddModalFormInfo(formType, lat, lng, reporter_name, reporter_email, date) {
  var formTitle = formType.split("-").map(word => word[0].toUpperCase() + word.substr(1)).join(" ");
  var formUrl = formType.split("-").slice(1).join("_");
  //takes the "s" off the end of the string
  var formName = formUrl.slice(0, -1);
  var modal = $("#add_pin");

  var lat = Number(lat);
  var lng = Number(lng);
  var latString, lngString;

  latString = convertLatLngToString(lat, "lat");
  lngString = convertLatLngToString(lng, "lng");

  modal.find(".report_title").html(formTitle);
  modal.find(".report_lat").html(latString);
  modal.find(".report_lng").html(lngString);
  modal.find(".form-horizontal").attr("action", "/" + formUrl + "/add");

  modal.find("#add_pin_lat").attr("value", lat);
  modal.find("#add_pin_lat").attr("name", formName + "[lat]");
  modal.find("#add_pin_lng").attr("value", lng);
  modal.find("#add_pin_lng").attr("name", formName + "[lng]");
  modal.find("#add_pin_reporter").attr("value", reporter_name.toString() + " (" + reporter_email.toString() + ")");
  modal.find("#add_pin_reporter").attr("name", formName + "[reporter]");
  modal.find("#add_pin_dateTime").attr("value", date);
  modal.find("#add_pin_dateTime").attr("name", formName + "[dateTime]");
}

function setDeleteModalFormInfo(deleteType, report_id) {
  var report = $("#" + deleteType + "_" + report_id);
  var report_date = report.find(".report_date");

  var formTitle = deleteType.split("_").map(word => word[0].toUpperCase() + word.substr(1)).join(" ");
  var formUrl = deleteType;
  //takes the "s" off the end of the string
  var formName = deleteType.slice(0, -1)

  if (formName == "spray_dat") formName = "spray_datum";

  var modal = $("#delete_pin");
  modal.find(".report_title").html(formTitle);
  modal.find(".form-horizontal").attr("action", "/" + formUrl + "/delete");
  modal.find(".report_id").html(report_id);
  modal.find(".report_date").html(report_date);
  modal.find("#delete_pin_id").attr("value", report_id)
  modal.find("#delete_pin_id").attr("name", formName + "[id]")
}

function setDataModalFormInfo(formType, lat, lng, reporter_name, reporter_email, date) {
  var formTitle = formType.split("-").map(word => word[0].toUpperCase() + word.substr(1)).join(" ");
  var formUrl = formType.split("-").slice(1).join("_");
  //takes the "s" off the end of the string
  var formName = formUrl;
  var modal = $("#add_data");

  var lat = Number(lat);
  var lng = Number(lng);
  var latString, lngString;

  latString = convertLatLngToString(lat, "lat");
  lngString = convertLatLngToString(lng, "lng");

  modal.find(".report_title").html(formTitle);
  modal.find(".report_lat").html(latString);
  modal.find(".report_lng").html(lngString);
  modal.find(".form-horizontal").attr("action", "/" + formName + "/add");

  modal.find("#add_data_lat").attr("value", lat);
  modal.find("#add_data_lat").attr("name", formName + "[lat]");
  modal.find("#add_data_lng").attr("value", lng);
  modal.find("#add_data_lng").attr("name", formName + "[lng]");
  modal.find("#add_data_foreman").attr("value", reporter_name.toString());
  modal.find("#add_data_foreman").attr("name", formName + "[foreman]");
  modal.find("#add_data_dateTime").attr("value", date);
  modal.find("#add_data_dateTime").attr("name", formName + "[dateTime]");
  modal.find("#add_data_imei").attr("name", formName + "[imei]");
  modal.find("#add_data_chemical_used").attr("name", formName + "[chemical_used]");
  modal.find("#add_data_unsprayed_rooms").attr("name", formName + "[unsprayed_rooms]");
  modal.find("#add_data_unsprayed_shelters").attr("name", formName + "[unsprayed_shelters]");
  modal.find("#add_data_is_mopup_spray").attr("name", formName + "[is_mopup_spray]");

  var index = 0;
  $('form').on('click', '.add_fields', function(event) {
    var regexp;
    index++;
    regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data('fields').replace(regexp, index));
    modal.find("#add_data_is_refilled").attr("id", "refilled_" + index);
    modal.find("#refilled_" + index).attr("name", formName + "[refilled][" + index + "]");
    return event.preventDefault();
  });
}

function setEditModalFormInfo(editType, report_id, lat, lng) {
  var report = $("#" + editType + "_" + report_id);


  var formTitle = editType.split("_").map(word => word[0].toUpperCase() + word.substr(1)).join(" ");
  var formUrl = editType;
  //takes the "s" off the end of the string
  var formName = (formUrl == "spray_data") ? "spray_datum" : editType.slice(0, -1);
  
  var lat = Number(lat);
  var lng = Number(lng);
  var latString, lngString;

  latString = convertLatLngToString(lat, "lat");
  lngString = convertLatLngToString(lng, "lng");

  var modal = $("#move_pin");
  modal.find(".report_title").html(formTitle);
  modal.find(".report_lat").html(latString);
  modal.find(".report_lng").html(lngString);

  modal.find(".form-horizontal").attr("action", "/" + formUrl + "/edit_location");
  modal.find(".report_id").html(report_id);
  modal.find("#edit_pin_id").attr("value", report_id)
  modal.find("#edit_pin_id").attr("name", formName + "[id]")
  modal.find("#edit_data_lat").attr("value", lat);
  modal.find("#edit_data_lat").attr("name", formName + "[lat]");
  modal.find("#edit_data_lng").attr("value", lng);
  modal.find("#edit_data_lng").attr("name", formName + "[lng]");
}

function convertLatLngToString(coord, latLng) {
  if ((latLng != "lat") && (latLng != "lng"))
    throw "latLng is neither 'lat' nor 'lng': " + latLng;
  var isLat = latLng == "lat";
  var dir = (coord < 0) ? (isLat ? "S" : "W") : (isLat ? "N" : "E");
  return Math.abs(coord.toFixed(5)).toString() + " " + dir;
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

    $(".toggle-add-future-spray-locations").click(function() { toggleSelectedButton(addFutureSprayLocations) });
    $(".toggle-add-malaria-reports").click(function() { toggleSelectedButton(addMalariaReports) });
    $(".toggle-add-spray-data").click(function() { toggleSelectedButton(addSprayData) });
    $(".sidebar_item").click(function() { mapMode = defaultMode });
  }
}


$(document).on('turbolinks:load', loadJSForInitMap);
