const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.trip_table;
const fs = require('fs');
const Map = require('./../business_flow/map/geojson');
const world_popular_points = JSON.parse(fs.readFileSync('../core/business_flow/map/world_popular_points.json', 'utf8'));
console.log("World points contains", world_popular_points.features.length, "points");
const Turf = require('@turf/turf');
const Bank = require('../business_flow/user/ewallet');

module.exports.invite_driver = function(details, onSuccessCallback, onFailureCallback){
    let {trip_id, vehicle_id} = details;
    pool.query(
        "UPDATE " + table_name + " SET inviting_vehicle = ?, state = 'INVITING' WHERE id = ?",
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
const is_user_own_trip = function(details, onOwn, onFailureCallback){
    let {trip_id, owner_id} = details;
    pool.query(
        "SELECT * FROM trip WHERE id = ? and owner_id = ?",
        [trip_id, owner_id],
        function (err, trips) {
            if (err) onFailureCallback(err);
            else {

                if (trips.length) {
                    utils.identify("trip", trips[0]);
                    onOwn(trips[0]);
                }
                else onFailureCallback({message: "User not own this trip"});
            }
        }
    );
};
const is_on_trip = function(details, onBelongToTrip, onFailureCallback){
    let {trip_id, picked_user_id, driver_id} = details;
    let expect_result_count = 2;
    if( !picked_user_id || !driver_id) expect_result_count -=1;
    pool.query(
        "SELECT * FROM on_trip WHERE user_id IN (?,?)  and trip_id = ?",
        [driver_id, picked_user_id, trip_id],
        function (err, on_trip_users) {
            if (err) onFailureCallback(err);
            else {
                if (on_trip_users.length == expect_result_count) {
                    utils.identify("trip", on_trip_users);
                    onBelongToTrip(on_trip_users);
                }
                else onFailureCallback({message: "Passenger or driver is not belong to this trip"});
            }
        }
    );
};
const nSafe_passenger_on_trip = function(trip_id, onSuccessCallback, onFailureCallback){
    pool.query(
        "SELECT * FROM on_trip WHERE trip_id = ?",
        [trip_id],
        function (err, on_trip_users) {
            if (err) onFailureCallback(err);
            else onSuccessCallback(on_trip_users);
        }
    );
};
const get_trip_location = function(details, onLocation, onFailureCallback){
    let {driver_id} = details;
    pool.query(
        "SELECT location FROM user WHERE username = ?",
        [driver_id],
        function (err, location) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("location", location);
                if (location.length) {
                    onLocation(location[0].location);
                }
                else onFailureCallback({message: location});
            }
        }
    );
};
const is_driver_drive_trip = function(details, onOwn, onFailureCallback){
    let {trip_id, driver_id, vehicle_id} = details;
    pool.query(
        "SELECT * FROM trip_driver WHERE id = ? and driver_id = ? and vehicle_id = ?",
        [trip_id, driver_id, vehicle_id],
        function (err, trip_driver) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("trip_driver", trip_driver);
                if (trip_driver.length) {
                    onOwn(trip_driver[0]);
                }
                else onFailureCallback({message: "Driver or vehicle not on this trip"});
            }
        }
    );
};
module.exports.fetch = function (details, onSuccessCallback, onFailureCallback) {
    let {user_id, trip_id} = details;
    is_on_trip(
        {picked_user_id: user_id, trip_id: trip_id},
        function (on_trip) {
            nSafe_get_current_trip(
                trip_id,
                function (trip_driver){
                    nSafe_passenger_on_trip(trip_id,
                        function (on_trip_users) {
                            trip_driver.passengers = on_trip_users;
                            onSuccessCallback(trip_driver);
                        },
                        onFailureCallback
                    );
                },
                onFailureCallback
            )
        }, onFailureCallback
    );
};
module.exports.pay = function (details, onSuccessCallback, onFailureCallback) {
    let {user_id, trip_id, accountNumber} = details;
    is_on_trip(
        {picked_user_id: user_id, trip_id: trip_id},
        function (on_trip) {
            nSafe_get_current_trip(
                trip_id,
                function (trip_driver){
                    let amount = trip_driver.whole_trip_price;
                    Bank.pay(
                        {accountNumber:accountNumber, amount:amount, user_id:user_id},
                        function () {
                            let driver_id = trip_driver.driver_id;
                            Bank.get_default_ewallet(
                                driver_id,
                                function (ewallet) {
                                    Bank.receive(
                                        {accountNumber: ewallet.accountNumber, amount: amount, user_id: driver_id},
                                        function () {
                                            if (trip_driver.owner_id == user_id) {
                                                nSafe_paid(trip_id,
                                                    onSuccessCallback,
                                                    onFailureCallback);
                                            }
                                            else onSuccessCallback();
                                        },
                                        function () {
                                            onFailureCallback({"Error": "accountNumber not found"});
                                        },
                                        function () {
                                            onFailureCallback({'Error': "Withdraw failed, lower than 0"});
                                        }
                                    );
                                }, onFailureCallback
                            )
                        },
                        function () {
                            onFailureCallback({"Error": "accountNumber not found"});
                        },
                        function () {
                            onFailureCallback({'Error': "Withdraw failed, lower than 0"});
                        }
                    )
                },
                onFailureCallback
            )
        }, onFailureCallback
    );
};
const create_share_details = function(details, onSuccessCallback, onFailureCallback){
    let {trip_id, avg_price, route} = details;
    let linestring = Map.route.toLineString(route);
    is_user_own_trip(details,
        function (trip) {
            pool.query(
                `INSERT INTO share_route_details (trip_id, avg_price, route ) VALUES (?, ?, GeomFromText(?))`,
                [trip_id, avg_price, linestring],
                function (err, result) {
                    if (err) onFailureCallback(err);
                    else {
                        utils.identify("store route", result);
                        onSuccessCallback(result);
                    }
                }
            );
        },
        onFailureCallback
    );
};
module.exports.create_share_details = create_share_details;
module.exports.enable_share = function(details, onSuccessCallback, onFailureCallback){
    let {trip_id} = details;
    is_user_own_trip(details,
        function (trip) {
            pool.query(
                "UPDATE trip SET share = 1 WHERE id = ?",
                [trip_id],
                function(err, result) {
                    if(err) onFailureCallback(err);
                    else {
                        details.route = Map.route.get(JSON.parse(trip.route), "Route").geometry;
                        create_share_details(details, onSuccessCallback, onFailureCallback);
                    }
                }
            );
        },
        onFailureCallback
    );
};

module.exports.driver_get_current_trip = function(user_id, onSuccessCallback, onFailureCallback){
    pool.query(
        "SELECT * FROM trip_driver WHERE driver_id = ?",
        [user_id],
        function(err, jobs) {
            if(err) onFailureCallback(err);
            else onSuccessCallback(jobs);
        }
    );
};
const nSafe_get_current_trip = function(trip_id, onSuccessCallback, onFailureCallback){
    pool.query(
        "SELECT * FROM trip_driver WHERE id = ?",
        [trip_id],
        function(err, trip_driver) {
            if(err) onFailureCallback(err);
            else if( trip_driver.length == 1) onSuccessCallback(trip_driver[0]);
            else onFailureCallback({message: "some thing wrong"});
        }
    );
};
const join_trip = function(details, onJoined, onFailureCallback){
    let {trip_id, driver_id, picked_user_id} = details;
    user = driver_id;
    if (picked_user_id) user = picked_user_id;
    get_trip_location(details,
        function (location){
            utils.identify("Location", location);
            pool.query(
                "INSERT INTO on_trip (user_id, trip_id, geton_location) VALUES (?, ?, POINT(?,?)) ON DUPLICATE KEY UPDATE geton_location =  POINT(?,?)",
                [user, trip_id, location.x, location.y, location.x, location.y],
                function(err, geton_status) {
                    if (err) onFailureCallback(err);
                    else onJoined(geton_status);
                }
            );
        }, onFailureCallback
    );
};
const leave_trip = function(details, onJoined, onFailureCallback){
    let {trip_id, driver_id, picked_user_id} = details;
    user = driver_id;
    if (picked_user_id) user = picked_user_id;
    get_trip_location(details,
        function (location){
            utils.identify("Location", location);
            pool.query(
                "UPDATE on_trip SET getoff_location =  POINT(?,?) WHERE user_id = ? and trip_id = ?",
                [location.x, location.y, user, trip_id],
                function(err, getoff_status) {
                    if (err) onFailureCallback(err);
                    else onJoined(getoff_status);
                }
            );
        }, onFailureCallback
    );
};
const book_trip = function(details, onJoined, onFailureCallback){
    let {trip_id, user_id} = details;
    pool.query(
        "INSERT INTO on_trip (user_id, trip_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE geton_location = null",
        [user_id, trip_id],
        function(err, geton_status) {
            if (err) onFailureCallback(err);
            else onJoined(geton_status);
        }
    );
};
module.exports.start = function(details, onSuccessCallback, onStarted, onFailureCallback){
    let {trip_id} = details;
    is_driver_drive_trip(details,
        function (trip_driver) {
            pool.query(
                "UPDATE trip SET state = 'STARTED' WHERE id = ? and state != 'STARTED'",
                [trip_id],
                function(err, result) {
                    if(err) onFailureCallback(err);
                    else if(result.changedRows) {
                        join_trip(
                            {trip_id: trip_id, driver_id: trip_driver.driver_id},
                            function (join_result) {
                                onSuccessCallback(join_result);
                            }, onFailureCallback
                        );
                    }
                    else onStarted();
                }
            );
        },
        onFailureCallback
    );
};
const nSafe_paid = function(trip_id, onSuccessCallback, onStarted, onFailureCallback){
    pool.query(
        "UPDATE trip SET state = 'PAID' WHERE id = ? and state != 'PAID'",
        [trip_id],
        function(err, result) {
            if(err) onFailureCallback(err);
            else onSuccessCallback();
        }
    );
};

module.exports.check_destination = function(details, onDoneTripCallback, onGoingCallback, onFailureCallback){
    let {trip_id} = details;
    is_driver_drive_trip(details,
        function (trip_driver) {
            let loc = trip_driver.location;
            let distance_left = Map.route.distance(
                Turf.point([loc.x, loc.y]),
                Map.route.get(JSON.parse(trip_driver.route), "End")
            );
            utils.identify("distance_left", distance_left);
            if (distance_left < 200) {
                pool.query(
                    "UPDATE trip SET state = 'ENDED' WHERE id = ?",
                    [trip_id],
                    function (err, result) {
                        if (err) onFailureCallback(err);
                        else onDoneTripCallback(result);
                    }
                );
            } else onGoingCallback();
        },
        onFailureCallback
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
                        "SELECT * FROM vehicle WHERE driver_id = ?",
                        [driver_id],
                        function (err, vehicles) {
                            utils.identify("vehicle of driver", vehicles);
                            if (err) onFailureCallback(err);
                            else {
                                let item = 0;
                                let accepted = false;
                                vehicles.forEach(function (vehicle, index, array) {
                                    item++;
                                    if (vehicle.id == vehicle_id) {
                                        let road_length = trips[0].road_length;
                                        let open_price = vehicle.open_price;
                                        let trip_price = vehicle.trip_price;
                                        let whole_trip_price = open_price + road_length*trip_price;
                                        let avg_price = whole_trip_price/road_length;
                                        pool.query(
                                            "UPDATE " + table_name + " SET inviting_vehicle = null, whole_trip_price = ?, open_price = ?, avg_price = ?, vehicle_id = ?, state = 'ACCEPTED' WHERE id = ?",
                                            [whole_trip_price, open_price,avg_price ,vehicle_id, trip_id],
                                            function (err, result) {
                                                if (err) onFailureCallback(err);
                                                else {
                                                    accepted = true;
                                                    onSuccessCallback(result);
                                                }
                                            }
                                        );
                                    } else if (!accepted && item == vehicles.length) onNotFound();
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
    is_user_own_trip(details,
        function (trip) {
            onSuccessCallback(JSON.parse(trip.route));
        },
        onFailureCallback
    );
};
module.exports.pickup = function (details, onSuccessCallback, onFailureCallback) {
    is_on_trip(details,
        function (trip) {
            join_trip(
                details,
                function (geton_status) {
                    onSuccessCallback(geton_status);
                }, onFailureCallback
            );
        },
        onFailureCallback
    );
};
module.exports.dropoff = function (details, onSuccessCallback, onFailureCallback) {
    is_on_trip(details,
        function (trip) {
            leave_trip(
                details,
                function (getoff_status) {
                    onSuccessCallback(getoff_status);
                }, onFailureCallback
            );
        },
        onFailureCallback
    );
};
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
                let road_length = Map.route.get_road_length(route);
                pool.query(
                    "INSERT INTO " + table_name + " (id, owner_id, road_length, route, share, state) VALUES (?, ?, ?, ?, 0, 'NEW')",
                    [next_id, owner_id, road_length, JSON.stringify(route)],
                    function (err, result) {
                        if (err) onFailureCallback(err);
                        else {
                            book_trip(
                                {trip_id: next_id, user_id: owner_id},
                                function() {
                                    pool.query(
                                        "SELECT * FROM " + table_name + " WHERE id = ?",
                                        [next_id],
                                        function (err, result_id) {
                                            if (err) onFailureCallback(err);
                                            else {
                                                utils.identify("store route", result_id[0].id);
                                                onSuccessCallback(result_id[0].id);
                                            }
                                        }
                                    );
                                }, onFailureCallback
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