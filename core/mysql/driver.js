const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.driver_table;
module.exports.register = function (driver, onSuccessCallback, onFailureCallback) {
    const {id, city, district, address_line1, address_line2} = driver;
    pool.query(
        "INSERT INTO " + table_name + " (id, city, district, address_line1, address_line2) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE city = ?, district = ?, address_line1 = ? , address_line2 = ?",
        [id, city, district, address_line1, address_line2, city, district, address_line1, address_line2],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store driver", result);
                onSuccessCallback(result);
            }
        }
    );
};
module.exports.use_own_vehicle = function (details, onSuccessCallback, onNotFound, onFailureCallback) {
    const {trip_id, vehicle_id, driver_id} = details;
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
                        "UPDATE trip SET vehicle_id = ? WHERE id = ? and vehicle_id = null",
                        [vehicle_id, trip_id],
                        function (err, result) {
                            if (err) onFailureCallback(err);
                            else {
                                utils.identify("store driver", result);
                                if(result.affectedRows) onSuccessCallback(result);
                                else onNotFound()
                            }
                        }
                    );
                } else if (!accepted && item == result.length) onNotFound();
            });
        };
    });
};


module.exports.on_vehicle = function (details, onSuccessCallback, onFailureCallback) {
    const {id, vehicle_id} = details;
    pool.query(
        "UPDATE "+ table_name + " SET on_vehicle = ? WHERE id = ?",
        [ vehicle_id, id],
        function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("working driver", result);
            onSuccessCallback(result);
        }
    });
};