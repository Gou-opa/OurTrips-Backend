const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');
const table_name = config.vehicle_table;
const expired_time = config.vehicle_expired_time;
module.exports.store = function (vehicle, onSuccessCallback, onFailureCallback) {
    const {brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, driver_id} = vehicle;
    pool.query(
        "INSERT INTO "+table_name+" (brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, approval_status, driver_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [ brand, name, type, engine_cap, color, gross_ton, total_weight, n_passengers, 'WAITING' , driver_id],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store vehicle", result);
                onSuccessCallback(result);
            }
        }
    );
};

module.exports.approve = function(form, onSuccessCallback, onFailureCallback){
    const {id, employee_id} = form;
    let due_date = new Date(new Date().setDate(new Date().getDate()+expired_time));
    pool.query(
        "UPDATE "+table_name+" SET approval_status='APPROVED', approval_due_date=?, employee_id=? WHERE id=?",
        [due_date, employee_id, id],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store vehicle", result);
                onSuccessCallback(result);
            }
        }
    );
};
module.exports.fetch = function (max, onSuccessCallback, onFailureCallback) {
    let now = new Date(new Date().toUTCString());
    if (max <= 0){
        //fetch all
        pool.query(
            "SELECT * FROM " + table_name + " WHERE approval_status='WAITING' OR approval_due_date < " + now,
            [],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    } else {
        //fetch max
        pool.query(
            "SELECT * FROM " + table_name + " WHERE approval_status='WAITING' LIMIT "+ max,
            [],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    }
};
