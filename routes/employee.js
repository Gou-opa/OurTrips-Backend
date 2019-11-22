var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');
var Employee = require('../business_flow/user/employee');

router.post('/register', function (req, res) {
    Account.AuthenEmployeeThen(Employee.register, req, res)
});
router.post('/grant', function (req, res) {
    // su dung secret duoc admin dua cho de grant thanh employee
    Account.AuthenAdminThen(Employee.Grant, req, res)
});
router.post('/approve', function (req, res) {
    Account.AuthenEmployeeThen(Employee.Approve,  req, res)
});

// router.post('/rotate_key', function f(req, res) {
//     Account.AuthenRoleThen(SecretManager.rotateKey, 'admin', req, res)
// })
router.post('/licences', function (req, res) {
    Account.AuthenEmployeeThen(Employee.Fetch_licences, req, res);
});
router.post('/vehicles', function (req, res) {
    Account.AuthenEmployeeThen(Employee.Fetch_vehicles, req, res);
});
module.exports = router;