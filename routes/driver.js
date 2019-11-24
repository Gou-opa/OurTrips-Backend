var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
var driver = require('../core/business_flow/user/driver');
var licence = require('../core/business_flow/licence/licence');
var vehicle = require('../core/business_flow/vehicle/vehicle');
const Trip = require('../core/business_flow/map/trip');
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
router.post('/host', function (req, res) {
    Account.AuthenThen(driver.use_own_vehicle, req, res)
});
router.post('/start_trip', function (req, res) {
    Account.AuthenThen(Trip.start, req, res)
});
router.post('/accept', function (req, res) {
    Account.AuthenThen(Trip.accept, req, res)
});
router.put('/working', function (req, res) {
    Account.AuthenThen(driver.on_vehicle, req, res)
});
router.delete('/:type/:id', function (req, res) {
    Account.AuthenThen(driver.delete, req, res)
});
router.post('/pickup', function (req, res) {
    Account.AuthenThen(Trip.pickup, req, res);
});
router.post('/dropoff', function (req, res) {
    Account.AuthenThen(Trip.dropoff, req, res);
});
module.exports = router;