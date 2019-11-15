const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');

const table_name = config.user_table;

module.exports.store = function (details, onSuccessCallback, onFailureCallback) {
    let { name, gender, birthday, address, email, tel, nationality} = details;
    let role = 'user';
    let dob = new Date(birthday);
    pool.query(
        "INSERT INTO "+table_name+" (name, gender, dob, address, email, nationality, tel, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [name, gender, dob, address, email, nationality, tel, role],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("stored new user", result);
                onSuccessCallback(result);
            }
        }
    );
};