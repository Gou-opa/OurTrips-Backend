const pool = require('./connectionPool');
const config = require('./config');
const utils = require('../utils/utils');
const table_name = config.ewallet_table;

Number.prototype.zeropad = function(size) {
    var s = String(this);
    while (s.length < (size || 2)) {s = "0" + s;}
    return s;
};

module.exports.link = function (details, onSuccessCallback, onDuplicateCallback, onFailureCallback) {
    let {vendor,user_id,accountNumber} = details;
    pool.query(
        "SELECT * FROM " +table_name + " WHERE accountNumber = ? and user_id = ?",
        [accountNumber, user_id],
        function (err, result) {
            if(err) onFailureCallback(err);
            else {
                utils.identify("dup", result);
                if (result.length == 0) {
                    pool.query(
                        "INSERT INTO " + table_name + " (vendor, balance, accountNumber, user_id) VALUES (?, ?, ?, ?)",
                        [vendor, 0, accountNumber, user_id],
                        function (err, result) {
                            if (err) onFailureCallback(err);
                            else {
                                utils.identify("linked wallet", result);
                                onSuccessCallback();
                            }
                        }
                    );
                } else onDuplicateCallback();
            }
        }
    );
};
module.exports.increase = function (details, onSuccessCallback, onNotFound, onFailureCallback) {
    let {accountNumber, user_id, amount} = details;
    pool.query(
        "UPDATE " + table_name+ " SET balance = balance + ? WHERE user_id = ? and accountNumber = ?",
        [amount, user_id, accountNumber],
        function (err, result) {
            if(err) onFailureCallback(err);
            else {
                if(result.changedRows) onSuccessCallback();
                else onNotFound();
            }
        }
    )
};
module.exports.decrease = function (details, onSuccessCallback, onNotFound, onFailureCallback) {
    let {accountNumber, user_id, amount} = details;
    pool.query(
        "UPDATE " + table_name+ " SET balance = balance - ? WHERE user_id = ? and accountNumber = ?",
        [amount, user_id, accountNumber],
        function (err, result) {
            if(err) onFailureCallback(err);
            else {
                if(result.changedRows) onSuccessCallback();
                else onNotFound();
            }
        }
    )
};
module.exports.create = function (user_id, onSuccessCallback, onFailureCallback) {
    pool.query("SELECT MAX(id) as last_id FROM "+ table_name, [],
        function (err, result) {
        let last_max_id = result[0].last_id;
        if( err) onFailureCallback (err);
        else{
            if(last_max_id == null) last_max_id = 0;
            utils.identify("max", last_max_id);
            let accountNumber = (last_max_id+1).zeropad(34);
            pool.query(
                "INSERT INTO "+table_name+" (vendor, balance, accountNumber, user_id) VALUES (?, ?, ?, ?)",
                ["OurTrips",0,accountNumber,user_id],
                function (err, result) {
                    if (err) onFailureCallback(err);
                    else {
                        utils.identify("stored wallet", result);
                        onSuccessCallback(result);
                    }
                }
            );
        }
    });
};

module.exports.fetch_own = function (details, onSuccessCallback, onFailureCallback) {
    let {max, user_id} = details;
    if (max <= 0){
        //fetch all
        pool.query(
            "SELECT * FROM " + table_name + " WHERE user_id = ?",
            [user_id],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    } else {
        //fetch max
        pool.query(
            "SELECT * FROM " + table_name + " WHERE user_id = ? LIMIT "+ max,
            [user_id],
            function (err, result) {
                if(err) onFailureCallback(err);
                else onSuccessCallback(result);
            }
        );
    }
};