var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
var driver = require('../core/business_flow/user/driver');
var licence = require('../core/business_flow/licence/licence');
var vehicle = require('../core/business_flow/vehicle/vehicle');

router.post('/register', function (req, res) {
    Account.AuthenThen(driver.register, req, res)
});
router.post('/fetch', function (req, res) {
    Account.AuthenThen(driver.Fetch, req, res)
});

router.post('/add', function (req, res) {
    Account.AuthenThen(driver.add, req, res)
});
router.post('/host', function (req, res) {
    Account.AuthenThen(driver.use_own_vehicle, req, res)
});

router.put('/working', function (req, res) {
    Account.AuthenThen(driver.on_vehicle, req, res)
});
router.delete('/:type/:id', function (req, res) {
    Account.AuthenThen(driver.delete, req, res)
});
module.exports = router;