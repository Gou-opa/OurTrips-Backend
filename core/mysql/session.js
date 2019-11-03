const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.store = function (session, onSuccessCallback, onFailureCallback) {
    const {username, login_at, token, info, logged_out} = session;
    pool.query("INSERT INTO " + config.session_table + " (username, login_at, token, logged_out, info) VALUES (?, ?, ?, ?, ?)", [username, login_at, token, logged_out, info], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("store session", result);
            onSuccessCallback(result);
        }
    });
};

module.exports.get = function (session,onSuccessCallback,onFailureCallback) {
    const {username,token} = session;
    pool.query("SELECT * FROM " + config.session_table + " WHERE username = ? and token = ?", [username, token], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("find sessions", result);
            onSuccessCallback(result);
        }
    });
};
module.exports.logout = function (token,onSuccessCallback,onFailureCallback) {
    pool.query("UPDATE " + config.session_table + " SET logged_out = 1 WHERE token=?", [token], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("find session", result);
            onSuccessCallback();
        }
    });
};
module.exports.expireAll = function (onSuccessCallback) {
    pool.query("DELETE FROM " + config.session_table, function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("find session", result);
            onSuccessCallback(result);
        }
    });
}