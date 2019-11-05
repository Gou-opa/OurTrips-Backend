const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.register = function (employee, onSuccessCallback, onFailureCallback) {
    const {id, department, role, username} = employee;
    let bin_role = (role >>> 0).toString(2)
    pool.query("INSERT INTO " + config.employee_table + " (id, department, role, username) VALUES (?, ?, ?,?) ON DUPLICATE KEY UPDATE department = ?, role = ?, username=?", [id, department, bin_role, username, department, bin_role, username], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("grant employee", result);
            onSuccessCallback(result);
        }
    });
};
