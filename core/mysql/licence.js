const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.licence_table;
const expired_time = config.licence_expired_time;
module.exports.store = function (licence, onSuccessCallback, onFailureCallback) {
    const {id, driver_id, due_date, type, authority} = licence;
    let datetime_duedate = new Date(due_date);
    pool.query(
        "INSERT INTO " + table_name + " (id, due_date, type, authority, driver_id, approval_status) VALUES (?, ?, ?, ?, ?, ?)",
        [id, datetime_duedate, type, authority, driver_id, "WAITING"],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store session", result);
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
    if (max <= 0){
        //fetch all
        pool.query(
            "SELECT * FROM " + table_name + " WHERE approval_status='WAITING'",
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