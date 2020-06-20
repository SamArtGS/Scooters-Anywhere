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

router.get('/scooter',function(request,response){
  var opc = parseInt(request.query.opc);
  switch(opc){
    case 1:
      sql = "SELECT * FROM SCOOTER WHERE SCOOTER_ID<100";
      peticion.open(sql,[],false,response);
      break;
  }
  response.end;
});

app.use(router);
app.listen(3000,function(){
  console.log('Servidor Web - http://localhost:3000');
});
