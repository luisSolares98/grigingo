var conector = require('../mySql/mySql');
var leccionesController = require("./leccionesController");

var liga = {
    selectByUser: async function(req, res) {
        let body = req.body;
        let {id} = body;
        const query = `call sp_progresoByUser(${id})`;
        const conecion = conector.conectar();
        conecion.ejecutarQuery(query, (err, datos) => {
            if (err) {
                res.status(400).json({
                    status: 400,
                    mensaje: err
                });
            } else {

                res.json({
                    status: 200,
                    mensaje: "se realizo con exito la consulta",
                    items: datos[0]
                });
            }
        });
    },
};
module.exports = liga;