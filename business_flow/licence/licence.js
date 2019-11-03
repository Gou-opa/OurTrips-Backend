const LicenceManager = require('../../core/mysql/licence');
const utils = require('../../utils/utils');

module.exports.register = function (user_info, req, res) {
    let register_form = req.body;
    register_form.driver_id = user_info.info.sub;
    LicenceManager.store(register_form,
        function () {
            res.json({'status': 200, "message": "Ok, waiting for approval."})
        },
        function (err) {
            utils.identify("save vehicle error", [register_form, err]);
            res.json({"status": 500, "Error": err.message});
        }
    )
};