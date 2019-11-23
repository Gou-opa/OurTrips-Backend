const GeoJSON_parser = require('geojson-parser');
const GeoJSON = require('geojson');
const GeoJSONMerge = require('@mapbox/geojson-merge');
const fs = require('fs');

module.exports.point = function (name, lat, long){

    return GeoJSON_parser.parse(
        [{name: name, long: long, lat: lat}],
        {Point: ['lat', 'long']}
    );
};

