var conector = require('../mySql/mySql');

var liga = {
    selectAll: function(req, res) {
        const query = `select * from niveles`;
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
                    items: datos
                });
            }
        });
    },
};
module.exports = liga;