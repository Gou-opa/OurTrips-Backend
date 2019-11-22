var express = require('express');
var router = express.Router();


// phần đăng nhập
router.get('/', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 1, name: "Đăng nhập"});
});

router.get('/register', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 2, name: "Đăng ký"});
});

router.get('/forgot-password', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 0, name: "Quên mật khẩu"});
});

// hết phần đăng nhập

router.get('/home', function(req, res, next) {
	res.render('./component/home/home.ejs');
});


//xử lý ajax dropdown list, không động vô
router.get('/driver/tinh/:id', function(req, res) {
	res.sendFile(__dirname + '/data/district/'+req.params.id+".json");
});


module.exports = router;
