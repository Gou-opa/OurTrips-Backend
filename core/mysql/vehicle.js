const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.store = function (vehicle, onSuccessCallback, onFailureCallback) {
    const {brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, driver_id} = vehicle;
    let due_date = new Date(new Date().setFullYear(new Date().getFullYear() + 1))
    pool.query("INSERT INTO " + config.vehicle_table + " (brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, approval_status, approval_due_date, driver_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, 'WAITING', due_date , driver_id], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("store session", result);
            onSuccessCallback(result);
        }
    });
};