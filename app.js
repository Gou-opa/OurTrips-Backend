var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');




var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname,"public")));

var indexRouter = require('./routes');
app.use('/', indexRouter);
var userRouter = require('./routes/user');
app.use('/user', userRouter);
var vehicleRoute = require('./routes/vehicle');
app.use('/vehicle', vehicleRoute);
var driverRoute = require('./routes/driver');
app.use('/driver', driverRoute);
var licenceRoute = require('./routes/licence');
app.use('/licence', licenceRoute);
var employeeRoute = require('./routes/employee');
app.use('/employee', employeeRoute);
var ewalletRoute = require('./routes/ewallet');
app.use('/ewallet', ewalletRoute);
var routeRoute = require('./routes/route');
app.use('/route', routeRoute);



// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});
// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});



module.exports = app;
