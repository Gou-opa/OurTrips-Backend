const cognito = require('./../aws/coginito');
const utils = require('./../utils/utils');
const jwt = require('jsonwebtoken');
const config = require('./../config/config');
const SesionManager = require('./../mysql/session');
module.exports.RegisterUser = (form, req, res) => {
    cognito.RegisterUser(form,
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
                res.json({"status": 500, "Error": err.message})
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
            utils.identify("secret", config.secret);
            cognito.GetUserAttributes(cognitoUser,
                function (userAttributeList) {
                    utils.identify("user", userAttributeList);
                    const token = jwt.sign({"sub": userAttributeList['sub']}, config.secret); // sub == user id in cognito
                    SesionManager.store(
                        {user: userAttributeList['sub'], "token": token, "info": "device info put in here later"},
                        function (result) {
                            res.json({
                                "status": 200,
                                "Role": userAttributeList['custom:role'],
                                "user_info": userAttributeList,
                                "token": token
                            });
                        },
                        function (err) {
                            res.json({"status": 500, "Error": err.message});
                        }
                    );
                },
                function (err) {
                    utils.identify("Retrieve role error", [login_form, err]);
                    res.json({"status": 500, "Error": err.message});
                }
            );
        },
        function (err) {
            utils.identify("Login error", [login_form, err]);
            if (err.message === 'Incorrect username or password.') res.json({"status": 401, "Error": err.message});
            else res.json({"status": 500, "Error": err.message});
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