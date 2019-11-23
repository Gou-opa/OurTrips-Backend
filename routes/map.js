var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
const Trip = require('../core/business_flow/map/trip');

router.post('/register', function (req, res, next) {
    Account.AuthenThen(Trip.Create, req, res);
});
router.post('/find_driver', function (req, res, next) {
    Account.AuthenThen(Trip.find_driver, req, res);
});
router.post('/invite_driver', function (req, res, next) {
    Account.AuthenThen(Trip.invite_driver, req, res);
});
router.post('/accept', function (req, res) {
    Account.AuthenThen(Trip.accept, req, res)
});
module.exports = router;
