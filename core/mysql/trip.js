const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.trip_table;


module.exports.register_route = function (details, onSuccessCallback, onFailureCallback) {
    let {owner_id, route} = details;
    // let datetime_duedate = new Date(due_date);
    pool.query(
        "INSERT INTO " + table_name + " (owner_id, route) VALUES (?, ?)",
        [owner_id, JSON.stringify(route)],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("store route", result);
                onSuccessCallback(result);
            }
        }
    );
};