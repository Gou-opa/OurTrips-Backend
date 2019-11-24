const GeoJSON_parser = require('geojson-parser');
const GeoJSON = require('geojson');
const GeoJSONMerge = require('@mapbox/geojson-merge');
const fs = require('fs');
const Turf = require('@turf/turf');
const GeoJSONTool = require('geojson-tools');
module.exports.point = function (name, lat, long){

    return GeoJSON_parser.parse(
        [{name: name, long: long, lat: lat}],
        {Point: ['lat', 'long']}
    );
};

var route = {};
route.get = function(geojson, name){
    let features = geojson.features;
    var i = 0;
    for(; i< features.length; i++){
        if(features[i].properties.name == name) return features[i];
    }
    if (i == features.length) return null;
};
route.get_road_length = function (routejson) {
    let road = route.get(routejson, "Route");
    return Turf.length(road, {units: 'kilometers'});
};
route.toLineString = function(linestring_obj){
    let line_arr = GeoJSONTool.toArray(linestring_obj);
    console.log("linearr", line_arr);
    if(line_arr.length) {
        let sentence = "LINESTRING(";
        var i = 0;
        for (; i < line_arr.length; i++) {
            line = line_arr[i];
            if (i) sentence += ',';
            sentence += `${line[0].toString()} ${line[1].toString()}`
        }
        ;
        if (i == line_arr.length) {
            sentence += ')';
            return sentence
        }
    } else {
        return null;
    }
};
route.distance = function(fromP, toP){
    return Turf.distance(fromP, toP, {units: 'meters'});
};

module.exports.route = route;
