const pool = require('./connectionPool');
const config = require('./config');
const utils = require('./../utils/utils');

module.exports.store = function (session, onSuccessCallback, onFailureCallback) {
    const {user, token, info} = session;
    pool.query("INSERT INTO " + config.session_table + " (user, token, info) VALUES (?, ?, ?)", [user, token, info], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("store session", result);
            onSuccessCallback(result);
        }
    });
};

module.exports.get = function (session) {
    const token = session.token;
    pool.query("SELECT * FROM " + config.session_table + " WHERE token = ?", [token], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("find session", result);
            onSuccessCallback(result);
        }
    });
};
