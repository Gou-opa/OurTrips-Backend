const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.store = function (licence, onSuccessCallback, onFailureCallback) {
    const {id, driver_id, due_date, type, authority} = licence;
    let datetime_duedate = new Date(due_date);
    pool.query("INSERT INTO " + config.licence_table + " (id, due_date, type, authority, driver_id, approval_status) VALUES (?, ?, ?, ?, ?, ?)", [id, datetime_duedate, type, authority, driver_id, "WAITING"], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("store session", result);
            onSuccessCallback(result);
        }
    });
};