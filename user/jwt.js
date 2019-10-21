const jwt = require('jsonwebtoken');
const utils = require('./../utils/utils');
const SesionManager = require('./../mysql/session');
const config = require('./../config/config');

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
                        onFailureCallback({"message":"session not found in db"});
                        break;
                    case 1:
                        let user_session_stored = result[0];
                        if (user_session_stored.logged_out) onLogoutCallback();
                        else onSuccessCallback(decoded.user);
                        break;
                    default:
                        onFailureCallback({"message":"More than 1 session have same identities !"});
                        break;
                }


            }
        );

    } catch (err) {
        if(err.name == "TokenExpiredError") onExpiredCallback();
        else onFailureCallback(err);
    }
};