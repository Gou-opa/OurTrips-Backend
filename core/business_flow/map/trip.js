const utils = require('../../utils/utils');
const TripManager = require('../../mysql/map');
var sortJsonArray = require('sort-json-array');

module.exports.Create = function (user_info, req, res) {
    var {route} = req.body;
    TripManager.register_route(
        {owner_id: user_info.info.username, route: route},
        function (result) {
            res.status(200).json({"route": result})
        },
        function (err) {
            utils.identify("create route error", err);
            res.status(500).json({ "Error": err.message});
        }
    )
};
function get_start_coords(geojson, onFoundCallback){
    geojson.features.forEach(function (feature, index, array){
        if (feature.properties.name == 'Start') onFoundCallback({long: feature.geometry.coordinates[0], lat: feature.geometry.coordinates[1]});
    });
}
module.exports.find_driver = function (user_info, req, res) {
    let {trip, max_range} = req.body;
    TripManager.get_route(
        {user_id: user_info.username, trip_id: trip},
        function (trip) {
            get_start_coords(trip, function (location) {
                utils.identify("location of trip" , location);
                let {long, lat} = location;
                TripManager.point.find_near_driver(
                    {long: long, lat: lat, max_range: max_range},
                    function (result) {
                        res.status(200).json({"drivers": sortJsonArray(result, 'distance'), "count": result.length});
                    },
                    function (err) {
                        utils.identify("find driver error", err);
                        res.status(500).json({ "Error": err.message});
                    }
                )
            });
        },
        function (err) {
            utils.identify("find driver error", err);
            res.status(500).json({ "Error": err.message});
        }
    )

};
module.exports.invite_driver = function (user_info, req, res) {
    let {trip, vehicle} = req.body;
    TripManager.invite_driver(
        {trip_id: trip, vehicle_id: vehicle},
        function (result) {
            res.status(200).json({"status": "invited"});
        },
        function (err) {
            utils.identify("invite driver error", err);
            res.status(500).json({ "Error": err.message});
        }
    )
};
module.exports.accept = function (user_info, req, res) {
    let {trip, vehicle} = req.body;
    TripManager.driver_accept(
        {driver_id: user_info.username, trip_id: trip, vehicle_id: vehicle},
        function (result) {
            res.status(200).json({"status": "invited"});
        }, function(){
            res.status(404).json({ "Error": "Not found trip or vehicle"});
        },
        function (err) {
            utils.identify("invite driver error", err);
            res.status(500).json({ "Error": err.message});
        }
    )
};


const parse_route = function (route) {
    if (typeof route == 'string') route = JSON.stringify(route);
    let {type, features} = route;
    if(type == 'FeatureCollection') {
        routeObj = {};
        routeObj.stop = [];
        features.forEach(function (feature, index, array) {
            let title = feature.title;
            switch (title) {
                case "Start": {
                    routeObj.start = feature.geometry.coordinates;
                    break;
                }
                case "End": {
                    routeObj.end = feature.geometry.coordinates;
                    break;
                }
                case "Route": {
                    routeObj.route = feature.geometry.coordinates;
                    break;
                }
                default : {
                    let splitted = title.split('_')
                    if (splitted.length == 2 && splitted[0] == 'Stop') {
                        routeObj.stop.push(feature.geometry.coordinates)
                    }
                    break;
                }
            }
        });
        return routeObj;
    } else {
        return null;
    }
}