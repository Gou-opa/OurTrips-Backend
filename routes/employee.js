var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
var Employee = require('../core/business_flow/user/employee');

router.post('/register', function (req, res) {
    Account.AuthenEmployeeThen(Employee.register, req, res)
});
router.post('/grant', function (req, res) {
    // su dung secret duoc admin dua cho de grant thanh employee
    const ret_action = {
        onSuccess: Employee.Grant,
        onFailure: function (err_json, req, res) {
            res.status(500).json(err_json);
        }
    };
    Account.LoginUser(req.body, req, res, mode ='return', ret_func_pack = ret_action);
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