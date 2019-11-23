const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');

const table_name = config.user_table;

module.exports.store = function (details, onSuccessCallback, onFailureCallback) {
    let { username, name, gender, birthday, address, email, tel, nationality} = details;
    let role = 'user';
    let dob = new Date(birthday);
    pool.query(
        "INSERT INTO "+table_name+" (username, name, gender, dob, address, email, nationality, tel, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [username, name, gender, dob, address, email, nationality, tel, role],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("stored new user", result);
                onSuccessCallback(result);
            }
        }
    );
};
module.exports.set_location = function (details, onSuccessCallback, onFailureCallback) {
    let { username, location} = details;
    let { long, lat } =  location;
    pool.query(
        "UPDATE "+table_name+" SET location = POINT( "+ long + "," +lat+") WHERE username = ?",
        [ username],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                onSuccessCallback(result);
            }
        }
    );
};

module.exports.GetUserAttributes = function (username, onSuccessCallback, onFailureCallback) {
    pool.query(
        "SELECT * FROM "+table_name+" WHERE username = ?",
        [username],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("get user info", result);
                if(result.length == 1) onSuccessCallback(result[0]);
                else onFailureCallback({message: "returned 2 user"});
            }
        }
    );
};

module.exports.grant = function (details, onSuccessCallback, onFailureCallback) {
    let { username, role} = details;
    pool.query(
        "UPDATE "+table_name+" SET role = ? WHERE username = ?",
        [role, username],
        function (err, result) {
            if (err) onFailureCallback(err);
            else {
                utils.identify("grant user", result);
                onSuccessCallback(result);
            }
        }
    );
};