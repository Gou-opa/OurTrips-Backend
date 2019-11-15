const cognito = require('../../core/aws/coginito');
const utils = require('../../core/utils/utils');
const jwt = require('./jwt');
const SessionManager = require('../../core/mysql/session');
const UserManager = require('../../core/mysql/user');
const url = require('url');


module.exports.Verify = function (user_info, req, res) {
    var form = req.body;
    let action_permission;
    utils.identify('retrieved user pack', user_info);
    utils.identify('requred role', form.role);
    if (user_info['info']['custom:role'] == form.role) action_permission = true;
    else action_permission = false;
    res.status(200).json({"state": "authenticated", "action_permission" : action_permission});
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


const Authen2 = function (form, onSuccessCallback, onErrorCallback, onExpireCallback, onLoggedOutCallback) {
    jwt.checkConnection(
        {
            "username": form.req.body.username,
            "token" : form.req.body.token,
            "req": form.req,
            "res": form.res
        },
        onSuccessCallback, //parram user_info
        onErrorCallback, //parram err
        onExpireCallback, //0 param
        onLoggedOutCallback //0 param
    );
};
module.exports.AuthenThen = function(action, req, res){
    /*
    params: action: function (user_info object, req, res) { ... }
        use to launch action with user info and authenticated
        all infomation reserved in req so there is no need to pass any other input into action's params
        define extraction of req later in action definition
     */
    Authen2(
        {req: req, res: res},
        action,
        function (err) {
            res.status(500).json({"Error": err.message});
        },
        function () {
            res.status(401).json({ "Error": "Token expired"});
        },
        function () {
            res.status(401).json({ "Error": "User logged out"});
        }
    );
};

const AuthenRoleThen = function(action, role, req, res){
    /*
    params: action: function (user_info_object, req, res) { ... }
        use to launch action with user info and authenticated
        all infomation reserved in req so there is no need to pass any other input into action's params
        define extraction of req later in action definition
     */
    Authen2(
        {req: req, res: res},
        function (user_infopack, req, res){
            utils.identify("role of request", user_infopack);
            if(user_infopack['info']['role'] == role) action(user_infopack, req, res);
            else {
                res.status(403).json({"Error": "Not authorized as " + role});
            }
        },
        function (err) {
            res.status(500).json({ "Error": err.message});
        },
        function () {
            res.status(401).json({"Error": "Token expired"});
        },
        function () {
            res.status(401).json({"Error": "User logged out"});
        }
    );
};
module.exports.AuthenRoleThen = AuthenRoleThen;
module.exports.AuthenEmployeeThen = function(action, req, res){
    AuthenRoleThen(action, 'employee', req, res);
};
module.exports.LogOut = function (user, req, res) {
    var form = req.body;
    utils.identify('logging out user', form.username);
    SessionManager.logout(form.token,
        function () {
            res.status(200).json({"message": "logged out success"});
        },
        function (err) {
            utils.identify("update logout status failed", err);
            res.status(500).json({"message": "logging out failed at db"});
        }
    );
};
module.exports.RegisterUser = function(form, req, res) {
    cognito.RegisterUser(form,
        function (result) {
            UserManager.store(
                form,
                function (result) {
                    res.status(200).json({"Event": "Register success"});
                },
                function (err) {
                    utils.identify("store to db error", [form, err]);
                    res.status(500).json({"Error": err.message});
                }
            )
        },
        function (err) {
            if (err.message === "User already exists") {
                utils.identify("User exsisted", form);
                res.status(404).json({ "Error": "Exsist"})
            } else {
                utils.identify("Signup error", [form, err]);
                res.status(500).json({"Error": err.message})
            }
        }
    );
};

module.exports.ConfirmUser = (confirm_form, req, res) => {
    cognito.ConfirmUser(confirm_form,
        function (result) {
            utils.identify("confirm", result);
            LoginUser(confirm_form, req, res);
        },
        function (err) {
            utils.identify("confirm error", [confirm_form, err]);
            res.status(401).json({ "Error": "Invalid verification code provided, please try again."});
        }
    );
};

const LoginUser = function (login_form, req, res){
    cognito.LoginUser(login_form,
        function (credential, cognitoUser) {
            utils.identify("credential", credential);
            //utils.identify("secret", config.secret);
            UserManager.GetUserAttributes(login_form.username,
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
                                res.status(200).json({
                                    "Role": userAttributeList['custom:role'],
                                    "token": token
                                });
                            },
                            function (err) {
                                res.status(500).json({ "Error": err.message});
                            }
                        );
                    });
                },
                function (err) {
                    utils.identify("Retrieve role error", [login_form, err]);
                    res.status(500).json({"Error": err.message});
                }
            );
        },
        function (err) {
            utils.identify("Login error", [login_form, err]);
            if (err.message === 'Incorrect username or password.') res.status(401).json({ "Error": err.message});
            else if (err.message === 'User is not confirmed.'){
                res.redirect(
                    url.format(
                        {
                            pathname:"/user/verification",
                            query: {
                                "username": login_form.username,
                                "password": login_form.password
                            }
                        }
                    )
                );
            }
            else res.status(500).json({ "Error": err.message});
        }
    )
};
module.exports.LoginUser = LoginUser;
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