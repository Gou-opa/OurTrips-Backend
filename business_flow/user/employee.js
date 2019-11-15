const EmployeeManager = require('../../core/mysql/employee');
const LicenceManager = require('../../core/mysql/licence');
const VehicleManager = require('../../core/mysql/vehicle');
const cognito = require('../../core/aws/coginito');
const utils = require('../../core/utils/utils');
const secret = require('../../config/server_secret').secret.hex.secret;

module.exports.Grant = function (admin_infopack, req, res){
    let grant_form = req.body;

    if (grant_form.secret == secret){
        cognito.LoginUser(grant_form,
            function (credential, cognitoUser) {
                cognito.updateAttributes(cognitoUser, {Name: "custom:role", Value: grant_form.role},
                    function (result) {
                        res.status(200).json({'result' : result});
                    },
                    function (err) {
                        utils.identify("Update role error", [grant_form, err]);
                        res.status(500).json({ "Error": err.message});
                    }
                );
            },
            function (err) {
                utils.identify("Authen error", [grant_form, err]);
                if (err.message === 'Incorrect username or password.') res.status(401).json({"Error": err.message});
                else res.status(500).json({ "Error": err.message});
            }
        );
    } else {
        res.status(403).json({ "Error": "Secret wrong !"});
    }

};
module.exports.Approve = function(employee_info, req, res) {
    let {type, id, username} = req.body;
    switch (type) {
        case "vehicle": {
            VehicleManager.approve(
                {id: id, employee_id: employee_info.info.sub},
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
                {id: id, employee_id: employee_info.info.sub},
                function (result) {
                    utils.identify("approve", result);
                    res.status(200).json({"message": "Approved"});
                },
                function (err) {
                    utils.identify("approve err", err);
                    res.status(500).json({message: "Some error happened"});
                }
            );
        }
        default: {
            res.status(400).json({message: "Mismatch type"});
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
    register_form.id = employee_info.info.sub;
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