const UserManager = require('../../core/mysql/driver');
const utils = require('../../core/utils/utils');

module.exports.register = function (user_info, req, res) {
    let register_form = req.body;
    register_form.id = user_info.info.sub;
    UserManager.register(register_form,
        function () {
            res.json({'status': 200, "message": "Ok"})
        },
        function (err) {
            utils.identify("save vehicle error", [register_form, err]);
            res.json({"status": 500, "Error": err.message});
        }
    )
};