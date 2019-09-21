const cognito = require('./../aws/coginito');
const utils = require('./../utils/utils');

module.exports.RegisterUser = (form, req, res) => {
    cognito.RegisterUser(req, res, form,
        function (result) {
            let cognitoUser = result.user;
            console.log('user name is', cognitoUser.getUsername());
            res.json({"status": 200, "Event": "Register success"})
        },
        function (err) {
            if (err.message === "User already exists") {
                utils.identify("User exsisted", regist_form);
                res.json({"status": 404, "Error": "Exsist"})
            } else {
                utils.identify("Signup error", [regist_form, err]);
                res.json({"status": 500, "Error": "Unknown"})
            }
        }
    );
};
module.exports.ConfirmUser = (confirm_form, req, res) => {
    cognito.ConfirmUser(confirm_form,
        function (result) {
            utils.identify("confirm", result);
            res.json({"status": 200, "Event": "confirm success"})
        },
        function (err) {
            utils.identify("confirm error", [confirm_form, err]);
            res.json({"status": 401, "Error": "Invalid verification code provided, please try again."});
        }
    );
};

module.exports.LoginUser = (login_form, req, res) => {
    cognito.LoginUser(login_form,
        function (credential, cognitoUser) {
            utils.identify("credential", credential);
            cognito.GetUserRole(cognitoUser,
                function (role) {
                    res.json({"status": 200, "Role": role})
                },
                function (err) {
                    utils.identify("Retrieve role error", [login_form, err]);
                    res.json({"status": 500, "Error": "Retrieve role failed"});
                }
            );
        },
        function (err) {
            utils.identify("Login error", [login_form, err]);
            if (err.message === 'Incorrect username or password.') res.json({"status": 401, "Error": err.message});
            else res.json({"status": 500, "Error": "Unknown"});
        }
    )
};
/* this code use to verify attribute for AUTHORIZED user, with specified attrubute in form
module.exports.VerifyUser = (verify_form, req, res) => {
    cognito.VerifyUser(req, res, verify_form,
        function (result) {
            console.log('call result', result);
            res.json({"status": 200, "Event": "Verify success"})
        },
        function (err) {
            utils.identify("Verify error", [verify_form, err]);
            res.json({"status": 500, "Error": "Unknown"});
        }
    );
};
*/