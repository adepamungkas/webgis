// require Express
var express = require('express');

// setup usage of the Express router engine
var router = express.Router();

/* PostgreSQL and PostGIS module and connection setup */
// require Postgres module
var pg = require("pg");

// Setup connection
var username = "postgres" // sandbox username
var password = "admin" // read only privileges on our table
var host = "localhost:5432"
var database = "webgis" // database name
var conString = "postgres://"+username+":"+password+"@"+host+"/"+database; // Your Database Connection


// Set up your database query to display GeoJSON
var selectQuery = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, name)) As properties FROM tbl_polygon As lg) As f) As fc";


/* GET home page. */
router.get('/', function(req, res) {
    var client = new pg.Client(conString);
    client.connect();

    client
        .query(selectQuery)
        .then((result,row) => {
            // result.addRow(row);
            var data = result.rows[0].row_to_json;
            // res.send(result.rows[0].row_to_json);
            res.render('index', {
                title: "Cambrigde Map",
                jsonData: data
            });

        })
        .catch(e => console.error(e.stack));
});


/* GET Postgres GeoJSON data */
router.get('/data', function (req, res) {
    var client = new pg.Client(conString);
    client.connect();
    // promise
    client
        .query(selectQuery)
        .then((result,row) => {
           // result.addRow(row);

            res.send(result.rows[0].row_to_json);

        })
        .catch(e => console.error(e.stack));

});

/* GET the map page */
router.get('/index', function(req, res) {
    var client = new pg.Client(conString);
    client.connect();

    client
        .query(selectQuery)
        .then((result,row) => {
            // result.addRow(row);
            var data = result.rows[0].row_to_json;
           // res.send(result.rows[0].row_to_json);
            res.render('index', {
                title: "Cambrigde Map",
                jsonData: data
            });

        })
        .catch(e => console.error(e.stack));

});


/* GET the filtered page */
router.get('/filter*', function (req, res) {
    var name = req.query.name;
    console.log(name);
    if (name.indexOf("--") > -1 || name.indexOf("'") > -1 || name.indexOf(";") > -1 || name.indexOf("/*") > -1 || name.indexOf("xp_") > -1){
        console.log("Bad request detected");
        res.redirect('/index');
        return;
    } else {
        console.log("Request passed")
        var filter_query = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, name)) As properties FROM tbl_polygon As lg WHERE lg.name = \'" + name + "\') As f) As fc";
        var client = new pg.Client(conString);
        client.connect();

        client
            .query(filter_query)
            .then((result,row) => {
                // result.addRow(row);
                var data = result.rows[0].row_to_json;
                // res.send(result.rows[0].row_to_json);
                res.render('index', {
                    title: "result_searching",
                    jsonData: data
                });

            })
            .catch(e => console.error(e.stack));

    };
});

module.exports = router;
