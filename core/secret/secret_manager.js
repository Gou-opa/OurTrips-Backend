const fs = require('fs');
const crypto = require("crypto");

const config = require('../../config/config');
const server_secret = config.secret.hex.secret;
/*
Generate secret
 */



module.exports.rotateKey = function(admin_info, req, res) {
    var prime_length = config.DiffieHellman_prime_length;
    var diffHell = crypto.createDiffieHellman(prime_length);
    diffHell.generateKeys('hex');


    fs.writeFile("./../secret/grant_secret.json",
        JSON.stringify({
            "secret": {
                "creator": admin_info.info.username,
                "hex": {
                    "DiffieHellman": {
                        "public": diffHell.getPublicKey('hex'),
                        "signed": sign.sign(diffHell.getPrivateKey('hex'), 'hex')
                    }
                }
            },
        }),
        function (err) {
            if (err) {
                res.status(500).json({"Error": err});
            } else {
                res.status(200).json({"message": "ok"});
            }
        }
    );
};
