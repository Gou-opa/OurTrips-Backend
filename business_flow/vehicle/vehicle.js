const VehicleManager = require('../../core/mysql/vehicle');
const Account = require('./../user/account');
const utils = require('../../utils/utils');

module.exports.Register = function (register_form, req, res) {
    const token = register_form.token;
    const username = register_form.username;
    Account.Authen(
        {username: username, token: token},
        function (user_info) {
            delete register_form.token;
            delete register_form.username;
            utils.identify("after authen", user_info);
            register_form.driver_id = user_info.info.sub;
            utils.identify("regist form of vehicle", register_form);
            VehicleManager.store(register_form,
                function () {
                    res.json({'status': 200, "message" : "Ok, waiting for approval."})
                },
                function (err) {
                    utils.identify("save vehicle error", [register_form, err]);
                    res.json({"status": 500, "Error": err.message});
                })
        },
        function (err) {
            res.json({"status": 500, "Error": err.message});
        },
        function () {
            res.json({"status": 401, "Error": "Token expired"});
        }, function () {
            res.json({"status": 401, "Error": "User logged out"});
        }
    );
}
