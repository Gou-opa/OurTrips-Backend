var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
const Trip = require('../core/business_flow/map/trip');

router.post('/register', function (req, res) {
    Account.AuthenThen(Trip.Create, req, res);
});
router.post('/get', function (req, res) {
    Account.AuthenThen(Trip.get, req, res);
});
router.post('/find_driver', function (req, res) {
    Account.AuthenThen(Trip.find_driver, req, res);
});
router.post('/invite_driver', function (req, res) {
    Account.AuthenThen(Trip.invite_driver, req, res);
});
router.post('/share/enable', function (req, res) {
    Account.AuthenThen(Trip.enable_share, req, res);
});
router.post('/share/add', function (req, res) {
    Account.AuthenThen(Trip.add_share, req, res);
});

module.exports = router;
