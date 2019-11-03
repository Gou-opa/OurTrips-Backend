var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var Employee = require('../business_flow/user/employee');

router.post('/register', function (req, res) {
    Account.AuthenRoleThen(Employee.register, 'employee', req, res)
});
router.post('/grant', function (req, res) {
    // su dung secret duoc admin dua cho de grant thanh employee
    Account.AuthenThen(Employee.Grant, req, res)
});


module.exports = router;