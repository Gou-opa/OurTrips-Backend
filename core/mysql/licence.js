const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.licence_table;
const expired_time = config.licence_expired_time;

module.exports.store = function (details, onSuccessCallback, onFailureCallback) {
    let {licence, driver_id} = details;
    const {id, due_date, type, authority} = licence;
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
module.exports.delete = function(details, onSuccessCallback, onNotFound, onFailureCallback){
    const {id, driver_id} = details;
    pool.query(
        "DELETE FROM "+table_name+" WHERE id=? and driver_id = ?",
        [id, driver_id],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store vehicle", result);
                if(result.affectedRows) onSuccessCallback();
                else onNotFound();
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
module.exports.get = function (details, onSuccessCallback, onNotFound, onFailureCallback) {
    let {driver_id, id} = details;
    pool.query(
        "SELECT * FROM " + table_name + " WHERE driver_id=? and id = ?",
        [driver_id, id],
        function (err, result) {
            if(err) onFailureCallback(err);
            else {
                utils.identify("get", result);
                if(result.length) onSuccessCallback(result[0]);
                else onNotFound();
            }
        }
    );
};

module.exports.fetch_own = function (details, onSuccessCallback, onFailureCallback) {
    let {max, driver_id} = details;
    if (max <= 0){
        //fetch all
        pool.query(
            "SELECT * FROM " + table_name + " WHERE driver_id = ?",
            [driver_id],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    } else {
        //fetch max
        pool.query(
            "SELECT * FROM " + table_name + " WHERE driver_id = ? LIMIT "+ max,
            [driver_id],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    }
};