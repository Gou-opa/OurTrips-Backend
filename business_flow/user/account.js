const cognito = require('../../core/aws/coginito');
const utils = require('../../utils/utils');
const jwt = require('./jwt');
const SessionManager = require('../../core/mysql/session');

module.exports.Verify = function (form, req, res) {
    jwt.check(
        {
            "username": form.username,
            "token" : form.token
        },
        function (user_info) {
            let {username, info} = user_info;
            let action_permission;
            utils.identify('read user info', info);
            utils.identify('requred role', form.role);
            if (info['custom:role'] == form.role) action_permission = true;
            else action_permission = false;
            res.json({"status": "authenticated", "action_permission" : action_permission});
        },
        function (err) {
            utils.identify("token verify failed", err);
            res.json({"status": err.message});
        },
        function () {
            res.json({"status": "token expired"});
        },
        function () {
            res.json({"status": "logged out"});
        }
    );
};
module.exports.Authen = function (form, onSuccessCallback, onErrorCallback, onExpireCallback, onLoggedOutCallback) {
    jwt.check(
        {
            "username": form.username,
            "token" : form.token
        },
        onSuccessCallback, //parram user_info
        onErrorCallback, //parram err
        onExpireCallback, //0 param
        onLoggedOutCallback //0 param
    );
};
module.exports.LogOut = function (form, req, res) {
    function logout(user_info) {
        utils.identify('logging out user', form.username);
        SessionManager.logout(form.token,
            function () {
                res.json({"status": "logged out"});
            },
            function (err) {
                utils.identify("update logout status failed", err);
                res.json({"status": "logging out failed at db"});
            }
        );
    }
    jwt.check(
        {
            "username": form.username,
            "token" : form.token
        },
        logout,
        function (err) {
            utils.identify("token verify failed", err);
            res.json({"status": "verify token failed"});
        },
        logout,
        function () {
            res.json({"status": "logged out before"});
        }
    );
};
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
            //utils.identify("secret", config.secret);
            cognito.GetUserAttributes(cognitoUser,
                function (userAttributeList) {
                    utils.identify("user", userAttributeList);
                    jwt.create(
                        {
                        "username":login_form.username,
                        "info":userAttributeList
                        },
                        function (token) {
                        SessionManager.store( // luu vao db session
                            {
                                "username": login_form.username,
                                "login_at": new Date(),
                                "token": token,
                                "info": "device info put in here later",
                                "logged_out": 0
                            },
                            function (result) {
                                res.json({
                                    "status": 200,
                                    "Role": userAttributeList['custom:role'],
                                    "token": token
                                });
                            },
                            function (err) {
                                res.json({"status": 500, "Error": err.message});
                            }
                        );
                    });
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