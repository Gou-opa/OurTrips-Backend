/**
 * Config
 */
const Sync = require('sync');
const config = require('./config').cognito;
//const utils = require('./../utils/utils');

/**
 * cognito client config
 * see https://www.npmjs.com/package/amazon-cognito-identity-js for docs
 * @type {module:amazon-cognito-identity-js}
 */
const WindowMock = require('window-mock').default;
global.window = {localStorage: new WindowMock().localStorage};
global.navigator = () => null;
const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
//const CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
const AWS = require('./aws');
//const request = require('request');
//const jwkToPem = require('jwk-to-pem');
//const jwt = require('jsonwebtoken');
global.fetch = require('node-fetch');


const poolData = {
    UserPoolId: config.poolID, // Your user pool id here
    ClientId: config.clientID // Your client id here
};
const pool_region = config.pool_region;
const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);


/**
 *
 * @param regist_form
 *   include field: username, passwd, name, gender, birthday, address, email, tel, role
 * @param onSuccessCallback
 * @param onFailureCallback
 * @constructor
 */
module.exports.RegisterUser = function (regist_form, onSuccessCallback, onFailureCallback) {
    var attributeList = [];
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "name", Value: regist_form.name}));
    //attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name:"preferred_username",Value:"jay"}));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "gender", Value: regist_form.gender}));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({
        Name: "birthdate",
        Value: regist_form.birthday
    }));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "address", Value: regist_form.address}));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "email", Value: regist_form.email}));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "phone_number", Value: regist_form.tel}));
    attributeList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "custom:role", Value: regist_form.role}));


    userPool.signUp(regist_form.username, regist_form.password, attributeList, null, function (err, result) {
        if (err) {
            onFailureCallback(err);
        } else {
            return onSuccessCallback(result)
        }
    });
};

function GetAllAttribute(cognitoUser, onSuccessCallback, onFailureCallback) {
    cognitoUser.getUserAttributes(function (err, result) {
        if (err) onFailureCallback(err);
        else {
            let attribute_list = {};
            for (let i = 0; i < result.length; i++) {
                attribute_list[result[i].getName()] = result[i].getValue();
            }
            onSuccessCallback(attribute_list);
        }
    });
}

module.exports.GetUserAttributes = function (cognitoUser, onSuccessCallback, onFailureCallback) {
    Sync(GetAllAttribute(cognitoUser, onSuccessCallback, onFailureCallback));
};
module.exports.LoginUser = function (login_form, onSuccessCallback, onFailureCallback) {
    const authenticationData = {
        Username: login_form.username,
        Password: login_form.password
    };
    const authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);
    let userData = {
        Username: login_form.username,
        Pool: userPool,
    };
    let cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
            //var accessToken = result.getAccessToken().getJwtToken();
            let logins = {};
            logins['cognito-idp.' + pool_region + '.amazonaws.com/' + poolData.UserPoolId] = result.getIdToken().getJwtToken();
            onSuccessCallback(new AWS.CognitoIdentityCredentials({
                IdentityPoolId: 'ap-southeast-1_BN6yOeZRi', // your identity pool id here
                Logins: logins
            }), cognitoUser);
            /*refreshes credentials using AWS.CognitoIdentity.getCredentialsForIdentity()
            credentials.refresh(error => {
                if (error) {
                    console.error(error);
                } else {
                    // Instantiate aws sdk service objects now that the credentials have been updated.
                    // example: var s3 = new AWS.S3();
                    console.log('Successfully logged!');
                }
            });
            */
        },
        onFailure: onFailureCallback
    });
};

module.exports.ConfirmUser = function (confirm_form, onSuccessCallback, onFailureCallback) {
    let userData = {
        Username: confirm_form.username,
        Pool: userPool,
    };
    let cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.confirmRegistration(confirm_form.code, true, function (err, result) {
        if (err) onFailureCallback(err);
        else onSuccessCallback(result);
    });
};
/*  this code use to verify attribute for AUTHORIZED user, with specified attrubute in form
module.exports.VerifyUser = function (req, res, verify_form, onSuccessCallback, onFailureCallback) {
    let userData = {
        Username: verify_form.username,
        Pool: userPool,
    };
    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    var authenticationData = {
        Username: verify_form.username,
        Password: login_form.password
    };
    var authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);
    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
            var accessToken = result.getAccessToken().getJwtToken();
            var logins = {};
            logins['cognito-idp.' + pool_region + '.amazonaws.com/' + poolData.UserPoolID] = result.getIdToken().getJwtToken();
            onSuccessCallback(new AWS.CognitoIdentityCredentials({
                IdentityPoolId: 'ap-southeast-1_BN6yOeZRi', // your identity pool id here
                Logins: logins
            }));
            /*refreshes credentials using AWS.CognitoIdentity.getCredentialsForIdentity()
            credentials.refresh(error => {
                if (error) {
                    console.error(error);
                } else {
                    // Instantiate aws sdk service objects now that the credentials have been updated.
                    // example: var s3 = new AWS.S3();
                    console.log('Successfully logged!');
                }
            });
            * /
        },
        onFailure: onFailureCallback
    });
    let attribute = verify_form.verify_property;
    cognitoUser.getAttributeVerificationCode(attribute, {
        onSuccess: onSuccessCallback,
        onFailure: onFailureCallback,
        inputVerificationCode: function () {
            var verificationCode = verify_form.code;
            cognitoUser.verifyAttribute(attribute, verificationCode, this);
        },
    });


};
*/

// test
//RegisterUser(regist_form, SignUpSuccess ,utils.callback.onFailure);
//RegisterUser(regist_form, SignUpSuccess, SignUpFail);