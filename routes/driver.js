var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var driver = require('../business_flow/user/driver');
var licence = require('../business_flow/licence/licence');
var vehicle = require('../business_flow/vehicle/vehicle');
const data = require('./data/city.json');

router.get('/', function (req, res, next) {
    res.render('./component/driver/driver.ejs');
});

router.get('/add-driver', function (req, res, next) {
    res.render('./component/driver/addDriver.ejs', {data: data});
});

router.get('/edit-driver', function (req, res, next) {
    res.render('./component/driver/editDriver.ejs', {data: data});
});


router.post('/register', function (req, res) {
    Account.AuthenThen(driver.register, req, res)
});
router.post('/fetch', function (req, res) {
    Account.AuthenThen(driver.Fetch, req, res)
});

router.post('/add', function (req, res) {
    Account.AuthenThen(driver.add, req, res)
});


router.delete('/:type/:id', function (req, res) {
    Account.AuthenThen(driver.delete, req, res)
});
module.exports = router;