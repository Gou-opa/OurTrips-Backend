var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var driver = require('../business_flow/user/driver');

router.post('/register', function (req, res) {
    Account.AuthenThen(driver.register, req, res)
});

module.exports = router;