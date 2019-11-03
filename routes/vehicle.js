var express = require('express');
var router = express.Router();
var vehicle = require('../business_flow/vehicle/vehicle');
/* GET users listing. */
router.post('/register', function (req, res, next) {
    let register_form = req.body;
    vehicle.Register(register_form, req, res);
});

module.exports = router;
