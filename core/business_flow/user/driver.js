const UserManager = require('../../mysql/driver');
const utils = require('../../utils/utils');
const VehicleManager = require('../../mysql/vehicle');
const LicenceManager = require('../../mysql/licence');


module.exports.register = function (user_info, req, res) {
    let register_form = req.body;
    register_form.id = user_info.info.username;
    UserManager.register(register_form,
        function () {
            res.status(200).json({"message": "Ok"})
        },
        function (err) {
            utils.identify("Regist driver error", [register_form, err]);
            res.status(500).json({ "Error": err.message});
        }
    )
};
module.exports.on_vehicle = function (user_info, req, res) {
    let vehicle_id = req.body.vehicle;
    let driver_id = user_info.username;
    UserManager.on_vehicle(
        {vehicle_id: vehicle_id, id: driver_id},
        function () {
            res.status(200).json({"message": "Ok"})
        },
        function (err) {
            utils.identify("Regist driver error", [register_form, err]);
            res.status(500).json({ "Error": err.message});
        }
    )
};

module.exports.use_own_vehicle = function (user_info, req, res) {
    let {trip, vehicle} = req.body;
    driver_id = user_info.username;
    UserManager.use_own_vehicle(
        {trip_id: trip, vehicle_id: vehicle, driver_id: driver_id},
        function () {
            res.status(200).json({"message": "hosted"});
        },
        function(){
            res.status(404).json({ "Error": "Not found trip or vehicle"});
        },
        function (err) {
            utils.identify("Regist host trip error", err);
            res.status(500).json({ "Error": err.message});
        }
    )
};

module.exports.Fetch = function(user_info, req, res) {
    let {max, type, filter} = req.body;
    let driver_id = user_info.info.username;
    const doFilter = function (result) {
        if(filter && filter.length){
            result.forEach(function (value, index, array) {
                utils.identify("item", value);
                for(attribute_name in value) {
                    if (!filter.includes(attribute_name)) delete result[index][attribute_name];
                }
            });
            sendReult(result);
        } else {
            sendReult(result);
        }
    };
    const sendReult = function (result) {
        res.status(200).json({requests: result, count: result.length});
    };
    const onError = function (err) {
        utils.identify("fetch err", err);
        res.status(500).json({ Error: err});
    };
    switch (type) {
        case 'vehicle': {
            VehicleManager.fetch_own(
                {max: max, driver_id: driver_id},
                doFilter,
                onError
            );
            break;
        }
        case 'licence': {
            LicenceManager.fetch_own(
                {max: max, driver_id: driver_id},
                doFilter,
                onError
            );
            break;
        }
        case 'invitation': {
            VehicleManager.fetch_invitation( // khong su dung max
                driver_id,
                sendReult,
                onError
            );
            break;
        }
        default: {
            res.status(400).json({ message: "Mismatch type"});
        }
    }
};

module.exports.add = function (user_info, req, res) {
    let register_form = req.body;
    let type = register_form.type;
    if(register_form.hasOwnProperty(type)){
        switch (type) {
            case "vehicle" : {
                VehicleManager.store({driver_id: user_info.info.username, vehicle: register_form[type]},
                    function () {
                        res.status(200).json({"message": "Ok, waiting for approval."})
                    },
                    function (err) {
                        utils.identify("save vehicle error", [register_form, err]);
                        res.status(500).json({ "Error": err.message});
                    }
                );
                break;
            }
            case "licence" : {
                LicenceManager.store({driver_id: user_info.info.username, licence: register_form[type]},
                    function () {
                        res.status(200).json({"message": "Ok, waiting for approval."})
                    },
                    function (err) {
                        utils.identify("save vehicle error", [register_form, err]);
                        res.status(500).json({ "Error": err.message});
                    }
                );
                break;
            }
            case 'serve_policy' : {
                VehicleManager.serve({driver_id: user_info.info.username, serve: register_form[type]},
                    function () {
                        res.status(200).json({ "message": "Ok"})
                    },
                    function (err) {
                        utils.identify("create serve policy vehicle error", [register_form, err]);
                        res.status(500).json({ "Error": err.message});
                    },
                    function () {
                        res.status(404).json({ Error: "Vehicle id not match driver"})
                    }
                );
                break;
            }
            default: {
                res.status(400).json({message: "Mismatch type"});
            }
        }
    } else {
        res.status(400).json({message: "Malform payload"});
    }
};

module.exports.delete = function (user_info, req, res) {
    let {id, type} = req.params;
    let user_id = user_info.info.username;
    switch (type) {
        case "vehicle": {
            VehicleManager.delete(
                {driver_id: user_id, id: id},
                function () {
                    res.status(200).json({"message": "Deleted"})
                },
                function () {
                    res.status(403).json({ "Error": type + " id not found"});
                },
                function (err) {
                    utils.identify("delete vehicle error", err);
                    res.status(500).json({"Error": err.message});
                }
            );
            break;
        }
        case "licence": {
            LicenceManager.delete(
                {driver_id: user_id, id: id},
                function () {
                    res.status(200).json({ "message": "Deleted"})
                },
                function () {
                    res.status(403).json({"Error": type + " id not found"});
                },
                function (err) {
                    utils.identify("delete licence error", err);
                    res.status(500).json({"Error": err.message});
                }
            );
            break;
        }
        default: {
            res.status(400).json({message: "Mismatch type"});
        }
    }

};
