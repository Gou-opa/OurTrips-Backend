const utils = require('../../core/utils/utils');
const TripManager = require('../../core/mysql/trip');
module.exports.Create = function (user_info, req, res) {
    var {route} = req.body;
    let routeObj = parse_route(route);
    TripManager.register_route(
        {owner_id: user_info.info.username, route: route},
        function (result) {
            res.status(200).json({"message": "Registed route"})
        },
        function (err) {
            utils.identify("create route error", err);
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