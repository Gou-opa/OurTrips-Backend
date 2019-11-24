const EmployeeManager = require('../../mysql/employee');
const LicenceManager = require('../../mysql/licence');
const VehicleManager = require('../../mysql/vehicle');
const cognito = require('../../aws/coginito');
const utils = require('../../utils/utils');
const secret = require('../../../config/server_secret').secret.hex.secret;
const UserManager = require('../../mysql/user');

module.exports.Grant = function (admin_login_result, req, res){
    let grant_form = req.body;
    if (admin_login_result.Role == 'admin') {
        if (grant_form.secret == secret) {
            UserManager.grant(
                {username: grant_form.for_user, role: grant_form.role},
                function (result) {
                    res.status(200).json({'granted': result.changedRows});
                },
                function (err) {
                    utils.identify("Update role error", [grant_form, err]);
                    res.status(500).json({"Error": err.message});
                }
            );
        } else {
            res.status(403).json({"Error": "Secret wrong !"});
        }
    } else res.status(403).json({"Error": "Not authorized as admin"});

};
module.exports.Approve = function(employee_info, req, res) {
    let {type, id, username} = req.body;
    switch (type) {
        case "vehicle": {
            VehicleManager.approve(
                {id: id, employee_id: employee_info.info.username},
                function (result) {
                    utils.identify("approve", result);
                    res.status(200).json({"message": "Approved"});
                },
                function (err) {
                    utils.identify("approve err", err);
                    res.status(500).json({message: "Some error happened"});
                }
            );
            break;
        }
        case "licence": {
            LicenceManager.approve(
                {id: id, employee_id: employee_info.info.username},
                function (result) {
                    utils.identify("approve", result);
                    res.status(200).json({"message": "Approved"});
                },
                function (err) {
                    utils.identify("approve err", err);
                    res.status(500).json({message: "Some error happened"});
                }
            );
            break;
        }
        default: {
            res.status(400).json({message: "Mismatch type"});
            break;
        }
    }
};

module.exports.Fetch_licences = function(employee_info, req, res) {
    let max = req.body.max;
    LicenceManager.fetch(
        max,
        function (result) {
            res.status(200).json({requests: result, count: result.length});
        },
        function (err) {
            utils.identify("fetch err", err);
            res.status(500).json({message: "Some error happened"});
        }
    )
};

module.exports.Fetch_vehicles = function(employee_info, req, res) {
    let max = req.body.max;
    VehicleManager.fetch(
        max,
        function (result) {
            res.status(200).json({ requests: result, count: result.length});
        },
        function (err) {
            utils.identify("fetch err", err);
            res.status(500).json({message: "Some error happened"});
        }
    )
};

module.exports.register = function (employee_info, req, res) {
    let register_form = req.body;
    register_form.id = employee_info.info.username;
    EmployeeManager.register(register_form,
        function () {
            res.status(200).json({"message": "Ok"})
        },
        function (err) {
            utils.identify("save vehicle error", [register_form, err]);
            res.status(500).json({"Error": err.message});
        }
    )
};