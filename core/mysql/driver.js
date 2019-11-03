const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../../utils/utils');

module.exports.register = function (driver, onSuccessCallback, onFailureCallback) {
    const {id, city, district, address_line1, address_line2} = driver;
    pool.query("INSERT INTO " + config.driver_table + " (id, city, district, address_line1, address_line2) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE city = ?, district = ?, address_line1 = ? , address_line2 = ?", [id, city, district, address_line1, address_line2, city, district, address_line1, address_line2], function (err, result) {
        if (err) onFailureCallback(err);
        else {
            utils.identify("store driver", result);
            onSuccessCallback(result);
        }
    });
};