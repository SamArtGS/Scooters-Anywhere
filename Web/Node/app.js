var oracledb = require("oracledb");
var express = require("express");
var app = express();
var bodyParser = require("body-parser");
var methodOverride = require("method-override");
var peticion = require("./responseORCL");


app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(methodOverride());
app.use(bodyParser.raw());
app.use(bodyParser.text());

var router = express.Router();

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;


app.use(router);
app.listen(3000,function(){
  console.log('Servidor Web - http://localhost:3000');
});
