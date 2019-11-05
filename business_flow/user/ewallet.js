const BankManagement = require('./../../core/mysql/ewallet');
const utils = require('../../core/utils/utils');

module.exports.registerNewWallet = function (user_info, req, res) {
    BankManagement.create(
        user_info.info.sub,
        function () {
            res.json({'status': 200, "message": "Created"})
        },
        function (err) {
            utils.identify("Create wallet err", err);
            res.json({"status": 500, "Error": err.message});
        }
    );
};
module.exports.charge = function (user_info, req, res) {
    let {accountNumber, amount} = req.body;
    BankManagement.increase(
        {accountNumber: accountNumber, user_id: user_info.info.sub, amount: amount},
        function () {
            res.json({'status': 200, "message": "Charged"})
        },
        function () {
            res.json({"status": 403, "Error": "accountNumber not found"});
        },
        function (err) {
            utils.identify("charge err", err);
            res.json({"status": 500, "Error": err.message});
        });
};
module.exports.withdraw = function (user_info, req, res) {
    let {accountNumber, amount} = req.body;
    BankManagement.decrease(
        {accountNumber: accountNumber, user_id: user_info.info.sub, amount: amount},
        function () {
            res.json({'status': 200, "message": "Withdrawed"})
        },
        function () {
            res.json({"status": 403, "Error": "accountNumber not found"});
        },
        function (err) {
            utils.identify("charge err", err);
            res.json({"status": 500, "Error": err.message});
        });
};
module.exports.link = function (user_info, req, res) {
    let {vendor, accountNumber} = req.body;
    BankManagement.link(
        {user_id: user_info.info.sub, vendor: vendor, accountNumber: accountNumber},
        function () {
            res.json({'status': 200, "message": "Linked"})
        },
        function () {
            res.json({"status": 403, "message" : "account linked before"});
        },
        function (err) {
            utils.identify("Link account err", err);
            res.json({"status": 500, "Error": err.message});
        }
    );
};
module.exports.fetch = function (user_info, req, res) {
    let {max, filter} = req.body;
    const doFilter = function (result) {
        if(filter && filter.length){
            result.forEach(function (value, index, array) {
                utils.identify("item", value);
                for(attribute_name in value) {
                    if (!filter.includes(attribute_name)) delete result[index][attribute_name];
                }
            });
            sendReult(result);
        } else {
            sendReult(result);
        }
    };
    const sendReult = function (result) {
        res.json({status: 200, requests: result, count: result.length});
    };
    const onError = function (err) {
        utils.identify("fetch err", err);
        res.json({status: 500, Error: err});
    };
    BankManagement.fetch_own(
        {user_id: user_info.info.sub, max: max},
        doFilter,
        onError
    );
};
module.exports.get = function (user_info, req, res) {
    let {accountNumber} = req.body;
    BankManagement.link(
        {user_id: user_info.info.sub, vendor: vendor, accountNumber: accountNumber},
        function () {
            res.json({'status': 200, "message": "Linked"})
        },
        function () {
            res.json({"status": 403, "message" : "account linked before"});
        },
        function (err) {
            utils.identify("Link account err", err);
            res.json({"status": 500, "Error": err.message});
        }
    );
};