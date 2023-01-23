$(document).ready(function () {
    // init map
    doWork();
  
  
  
  });
  
  function doWork() {
    // Store our API endpoint as queryUrl.
    let queryUrl = `https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson`;
  
    // reset map container
    $("#mapContainer").empty();
    $("#mapContainer").append("<div id='map'></div>")
  
  
    // Perform a GET request to the query URL.
    d3.json(queryUrl).then(function (data) {
      console.log(data);
  
      // Using the features array sent back in the API data, create a GeoJSON layer, and add it to the map.
      makeMap(data);
  
    });
  }

  function makeRadius(mag) {
    return mag ** 8
  }
  
  function getColor(depth) {
    switch(true){
        case depth >90:
            return "#E06363";
        case depth >70:
            return "#E07363";
        case depth >50:
            return "#E07863";
        case depth >30:
            return "#E08863";        
        case depth >10:
            return "#E09363";
        default:
                return "E0B463";
    }
  }
  
  
  // make map
  function makeMap(data) {
  
    // STEP 1: CREATE THE BASE LAYERS
  
    let street = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    })
  
    let topo = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
      attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)'
    });
  
  
    // STEP 2: CREATE THE OVERLAY/DATA LAYERS

    let crcls = [];
  
    for (let i = 0; i < data.features.length; i++) {
      let equake = data.features[i];
      let location = equake.geometry.coordinates;
  
      if (location) {
        let circle = L.circle([location[1], location[0]], {
                            fillOpacity: 0.75,
                            color: getColor(location[2]),
                            weight: 7,
                            fillColor: getColor(location[2]),
                            radius: makeRadius(equake.properties.mag)
                        }).bindPopup(`<h1> ${equake.properties.title} </h1> `);
        
        
        
  
        crcls.push(circle);
      }
    }
  
    let circleLayer = L.layerGroup(crcls)
  
    // STEP 3: CREATE THE LAYER CONTROL OBJECTS
  
    let baseMaps = {
      Street: street,
      Topography: topo
    };
  
    // Overlays that can be toggled on or off
    let overlayMaps = {
      Markers: circleLayer
    };
  
  
    // STEP 4: INITIALIZE MAP
    let myMap = L.map("map", {
      center: [37.7749, -122.4194],
      zoom: 11,
      layers: [street, circleLayer]
    });
  
    // STEP 5: ADD LAYER CONTROL TO MAP
  
    // Create a layer control that contains our baseMaps and overlayMaps, and add them to the map.
    L.control.layers(baseMaps, overlayMaps).addTo(myMap);
  
  }
  