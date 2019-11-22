const BankManagement = require('./../../core/mysql/ewallet');
const utils = require('../../core/utils/utils');

module.exports.registerNewWallet = function (user_info, req, res) {
    BankManagement.create(
        user_info.info.username,
        function () {
            res.status(200).json({"message": "Created"})
        },
        function (err) {
            utils.identify("Create wallet err", err);
            res.status(500).json({ "Error": err.message});
        }
    );
};
module.exports.charge = function (user_info, req, res) {
    let {accountNumber, amount} = req.body;
    if (amount < 0) res.status(403).json({"Error" : "Negative amount"});
    else {
        BankManagement.increase(
            {accountNumber: accountNumber, user_id: user_info.info.username, amount: amount},
            function () {
                res.status(200).json({"message": "Charged"})
            },
            function () {
                res.status(403).json({"Error": "accountNumber not found"});
            },
            function (err) {
                utils.identify("charge err", err);
                res.status(500).json({"Error": err.message});
            }
        );
    }
};
module.exports.withdraw = function (user_info, req, res) {
    let {accountNumber, amount} = req.body;
    if (amount < 0) res.status(403).json({"Error" : "Negative amount"});
    else {
        BankManagement.decrease(
            {accountNumber: accountNumber, user_id: user_info.info.username, amount: amount},
            function () {
                res.status(200).json({"message": "Withdrawed"})
            },
            function () {
                res.status(403).json({"Error": "accountNumber not found"});
            },
            function () {
                res.status(403).json({'Error': "Withdraw failed, lower than 0"});
            },
            function (err) {
                utils.identify("charge err", err);
                res.status(500).json({"Error": err.message});
            }
        );
    }
};
module.exports.link = function (user_info, req, res) {
    let {vendor, accountNumber} = req.body;
    BankManagement.link(
        {user_id: user_info.info.username, vendor: vendor, accountNumber: accountNumber},
        function () {
            res.status(200).json({ "message": "Linked"})
        },
        function () {
            res.status(403).json({ "message" : "account linked before"});
        },
        function (err) {
            utils.identify("Link account err", err);
            res.status(500).json({ "Error": err.message});
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
        res.status(200).json({ requests: result, count: result.length});
    };
    const onError = function (err) {
        utils.identify("fetch err", err);
        res.status(500).json({ Error: err});
    };
    BankManagement.fetch_own(
        {user_id: user_info.info.username, max: max},
        doFilter,
        onError
    );
};
module.exports.get = function (user_info, req, res) {
    let {accountNumber} = req.body;
    BankManagement.get(
        {user_id: user_info.info.username, accountNumber: accountNumber},
        function (result) {
            res.status(200).json({"ewallet":result})
        },
        function () {
            res.status(403).json({"Error": "Wallet with account number not found"});
        },
        function (err) {
            utils.identify("Get account err", err);
            res.status(500).json({"Error": err.message});
        }
    );
};