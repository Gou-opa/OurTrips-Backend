const jwt = require('jsonwebtoken');
const utils = require('../../core/utils/utils');
const SesionManager = require('../../core/mysql/session');
const config = require('../../config/config');

const secret = config.secret;
const jwtexpires = config.jwt.expire;
utils.identify("secret pack", secret);
const HS256Key = secret.hex.secret;
//
// const { generateKeyPair } = require('crypto');
// generateKeyPair('rsa', {
//     modulusLength: 4096,
//     publicKeyEncoding: {
//         type: 'spki',
//         format: 'pem'
//     },
//     privateKeyEncoding: {
//         type: 'pkcs8',
//         format: 'pem',
//         cipher: 'aes-256-cbc',
//         passphrase: 'top secret'
//     }
// }, (err, publicKey, privateKey) => {
//     // Handle errors and use the generated key pair.
// });
module.exports.create = function (user_info, onSuccessCallback) {
    let token = jwt.sign({"user": user_info}, HS256Key, {expiresIn: jwtexpires});//, { algorithm: 'RS256'});
    if (token) onSuccessCallback(token);
    // sub == user id in cognito
};

module.exports.check = function (session, onSuccessCallback, onErrorCallback, onExpiredCallback, onLogoutCallback) {
    const {username, token} = session;
    try {
        let decoded = jwt.verify(token, HS256Key);
        SesionManager.get(
            session,
            function (result) {
                switch (result.length) {
                    case 0:
                        onErrorCallback({"message":"session not found in db"});
                        break;
                    case 1:
                        let user_session_stored = result[0];
                        if (user_session_stored.logged_out) onLogoutCallback();
                        else onSuccessCallback(decoded.user);
                        break;
                    default:
                        onErrorCallback({"message":"More than 1 session have same identities !"});
                        break;
                }


            },
            onErrorCallback
        );

    } catch (err) {
        if(err.name == "TokenExpiredError") onExpiredCallback();
        else onErrorCallback(err);
    }
};

module.exports.checkConnection = function (ConnectionSession, onSuccessCallback, onErrorCallback, onExpiredCallback, onLogoutCallback) {
    const {username, token, res, req} = ConnectionSession;
    try {
        let decoded = jwt.verify(token, HS256Key);
        utils.identify("decoded user", decoded);
        SesionManager.get(
            ConnectionSession,
            function (result) {
                switch (result.length) {
                    case 0:
                        onErrorCallback({"message":"session not found in db"});
                        break;
                    case 1:
                        let user_session_stored = result[0];
                        if (user_session_stored.logged_out) onLogoutCallback();
                        else onSuccessCallback(decoded.user, req, res);
                        break;
                    default:
                        onErrorCallback({"message":"More than 1 session have same identities !"});
                        break;
                }
            },
            onErrorCallback
        );

    } catch (err) {
        if(err.name == "TokenExpiredError") onExpiredCallback();
        else onErrorCallback(err);
    }
};