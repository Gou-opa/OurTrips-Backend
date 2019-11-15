var express = require('express');
var router = express.Router();
const Account = require('../business_flow/user/account');
const Trip = require('../business_flow/trip/trip');

router.post('/register', function (req, res, next) {
    Account.AuthenThen(Trip.Create, req, res);
});

module.exports = router;
