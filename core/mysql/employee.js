const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.register = function (driver, onSuccessCallback, onFailureCallback) {
    const {id, department, role} = driver;
    let bin_role = (role >>> 0).toString(2)
    pool.query("INSERT INTO " + config.employee_table + " (id, department, role) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE department = ?, role = ?", [id, department, bin_role, department, bin_role], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("grant employee", result);
            onSuccessCallback(result);
        }
    });
};
