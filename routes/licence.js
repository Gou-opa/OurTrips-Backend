var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var licence = require('../business_flow/licence/licence');

router.post('/register', function (req, res) {
    Account.AuthenThen(licence.register, req, res)
});

module.exports = router;
