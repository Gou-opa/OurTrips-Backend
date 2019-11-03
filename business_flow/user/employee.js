const EmployeeManager = require('../../core/mysql/employee');
const cognito = require('../../core/aws/coginito');
const utils = require('../../utils/utils');
const secret = require('../../config/config').secret.hex.secret;

module.exports.Grant = function (admin_infopack, req, res){
    let grant_form = req.body;
    if (grant_form.secret == secret){
        cognito.LoginUser(grant_form,
            function (credential, cognitoUser) {
                cognito.updateAttributes(cognitoUser, {Name: "custom:role", Value: grant_form.role},
                    function (result) {
                        res.json({'status': 200, 'result' : result});
                    },
                    function (err) {
                        utils.identify("Update role error", [grant_form, err]);
                        res.json({"status": 500, "Error": err.message});
                    }
                );
            },
            function (err) {
                utils.identify("Authen error", [grant_form, err]);
                if (err.message === 'Incorrect username or password.') res.json({"status": 401, "Error": err.message});
                else res.json({"status": 500, "Error": err.message});
            }
        );
    } else {
        res.json({"status": 403, "Error": "Secret wrong !"});
    }

};

module.exports.register = function (user_info, req, res) {
    let register_form = req.body;
    register_form.id = user_info.info.sub;
    EmployeeManager.register(register_form,
        function () {
            res.json({'status': 200, "message": "Ok"})
        },
        function (err) {
            utils.identify("save vehicle error", [register_form, err]);
            res.json({"status": 500, "Error": err.message});
        }
    )
};