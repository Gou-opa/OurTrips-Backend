const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.trip_table;
const fs = require('fs');
const world_popular_points = JSON.parse(fs.readFileSync('../core/business_flow/map/world_popular_points.json', 'utf8'));
console.log("World points contains", world_popular_points.features.length, "points");


module.exports.invite_driver = function(details, onSuccessCallback, onFailureCallback){
    let {trip_id, vehicle_id} = details;
    pool.query(
        "UPDATE " + table_name + " SET inviting_vehicle = ? WHERE id = ?",
        [vehicle_id, trip_id],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store route", result);
                onSuccessCallback(result);
            }
        }
    );
};
module.exports.driver_accept = function(details, onSuccessCallback, onNotFound, onFailureCallback){
    let {driver_id, trip_id, vehicle_id} = details;
    pool.query(
        "SELECT * FROM invitations WHERE trip_id = ?",
        [trip_id],
        function (err, trips) {
            if (err) onFailureCallback(err);
            else {
                if(trips.length) {
                    pool.query(
                        "SELECT id FROM vehicle WHERE driver_id = ?",
                        [driver_id],
                        function (err, result) {
                            utils.identify("vehicle of driver", result);
                            if (err) onFailureCallback(err);
                            else {
                                let item = 0;
                                let accepted = false;
                                result.forEach(function (vehicle, index, array) {
                                    item++;
                                    if (vehicle.id == vehicle_id) {
                                        pool.query(
                                            "UPDATE " + table_name + " SET inviting_vehicle = null, vehicle_id = ? WHERE id = ?",
                                            [vehicle_id, trip_id],
                                            function (err, result) {
                                                if (err) onFailureCallback(err);
                                                else {
                                                    accepted = true;
                                                    onSuccessCallback(result);
                                                }
                                            }
                                        );
                                    } else if (!accepted && item == result.length) onNotFound();
                                });
                            }
                        }
                    );
                } else onNotFound();
            }
        }
    )
};
module.exports.get_route = function (details, onSuccessCallback, onFailureCallback) {
    let {user_id, trip_id} = details;
    pool.query(
        "SELECT route FROM " + table_name + " WHERE owner_id = ? and id = ?",
        [user_id, trip_id],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store route", result);
                if(result.length == 1) onSuccessCallback(JSON.parse(result[0].route));
                else onFailureCallback({"message": "get route occur error"});
            }
        }
    )
}
module.exports.register_route = function (details, onSuccessCallback, onFailureCallback) {
    let {owner_id, route} = details;
    // let datetime_duedate = new Date(due_date);
    pool.query(
        "SELECT MAX(id) as last_id FROM "+ table_name,
        [],
        function (err, result) {
            let last_max_id = result[0].last_id;
            if (err) onFailureCallback(err);
            else {
                if (last_max_id == null) last_max_id = 0;
                utils.identify("max", last_max_id);
                let next_id = (last_max_id + 1).zeropad(34);
                pool.query(
                    "INSERT INTO " + table_name + " (id, owner_id, route) VALUES (?, ?, ?)",
                    [next_id, owner_id, JSON.stringify(route)],
                    function (err, result) {
                        if (err) onFailureCallback(err);
                        else {
                            pool.query(
                                "SELECT * FROM " +table_name+ " WHERE id = ?",
                                [next_id],
                                function(err, result_id){
                                    if (err) onFailureCallback(err);
                                    else {
                                        utils.identify("store route", result_id[0].id);
                                        onSuccessCallback(result_id[0].id);
                                    }
                                }
                            );
                        }
                    }
                );
            }
            ;
        }
    );
};

var point = {
    world_store: function (point_obj, onSuccessCallback, onFailureCallback) {
        let {properties, geometry} = point_obj;
        let {OBJECTID_1, name, admin, scalerank, datarank} = properties;
        let long = geometry.coordinates[0];
        let lat = geometry.coordinates[1];
        // let datetime_duedate = new Date(due_date);
        pool.query(
            "INSERT INTO world_points (id, name, admin, scalerank, datarank, coords) VALUES (?, ?, ?, ?, ?, POINT(?, ?)) ON DUPLICATE KEY UPDATE name = ?, admin= ?, scalerank= ?, datarank=?, coords = POINT(?, ?)",
            [OBJECTID_1, name, admin, scalerank, datarank, long, lat, name, admin, scalerank, datarank, long, lat],
            function (err, result) {
                if (err) onFailureCallback(err);
                else {
                    onSuccessCallback(result);
                }
            }
        );
    },
    find_near_driver: function (details, onSuccessCallback, onFailureCallback) {
        let {max_range, lat, long} = details;
        pool.query(
            "SELECT *, ROUND(ST_Distance_Sphere(location, POINT(?, ?))) as distance FROM working_driver where ST_Distance_Sphere(location, POINT(?, ?)) < ?;",
            [long, lat, long, lat, max_range],
            function (err, result) {
                if (err) onFailureCallback(err);
                else {
                    onSuccessCallback(result);
                }
            }
        );


    }
};

module.exports.point = point;

if (process.env.WORLDS_POINT == 'overwrite') {
    console.log("Processing world points . . . please wait");
    world_popular_points.features.forEach(function (point_obj, index, array) {
        point.world_store(
            point_obj,
            (result) => {
                if (index + 1 >= world_popular_points.features.length) console.log("Insert worlds points done");
            },
            (err) => {
                console.log(err.message)
            }
        )
    });
};