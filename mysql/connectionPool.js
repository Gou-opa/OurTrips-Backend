const config = require('./config');

const mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 10,
    host: config.host,
    user: config.user,
    password: config.password,
    database: config.database
});

// pool.end(function (err) {// all connections in the pool have ended});
//
// function defaultFailureCallback(err) {
//
// }

module.exports = pool;
//
// module.exports.getConnection = function(callback) {
//     pool.getConnection(function(err, connection) {
//         if(err) console.error(err);
//         else callback(connection);
//     });
//     // connection.release(); to close or forget connection
//
// };