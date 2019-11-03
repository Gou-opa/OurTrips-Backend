var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var vehicle = require('../business_flow/vehicle/vehicle');

router.post('/register', function (req, res) {
    Account.AuthenThen(vehicle.register, req, res)
});

module.exports = router;
