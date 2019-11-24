var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');


router.get('/', function(req, res, next) {
    res.render('./component/vehicle/vehicle.ejs');
});

router.get('/add-vehicle', function(req, res, next) {
    res.render('./component/vehicle/addVehicle.ejs');
});

router.get('/edit-vehicle', function(req, res, next) {
    res.render('./component/vehicle/editVehicle.ejs');
});

module.exports = router;
