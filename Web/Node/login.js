var oracledb = require("oracledb");
var express = require("express");
var app = express();
var session = require('express-session');
var bodyParser = require("body-parser");
var methodOverride = require("method-override");
var peticion = require("./responseORCL");
var path = require('path');
var md5 = require('md5');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(methodOverride());
app.use(bodyParser.raw());
app.use(bodyParser.text());

app.use(session({
	secret: 'proyectoBD',
	resave: true,
	saveUninitialized: true
}));
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

connection = {
      user          : "CG_PROY_ADMIN",
      password      : "samjor",
      connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
}

app.use(express.static('public'));

app.get('/', function(request, response) {
	response.sendFile(path.join(__dirname + '/IniciarSesion.html'));
});

app.post('/auth', async function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		sql = "SELECT COUNT(*) FROM USUARIO WHERE EMAIL = '"+username+"' AND PASSWORD = '"+md5(password)+"'";
		console.log(sql);
		try {
			connection =  await oracledb.getConnection(  {
     		user          : "CG_PROY_ADMIN",
      		password      : "samjor",
  			connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
		});
			const result = await connection.execute(sql);
			const resultado = await result.rows;
			console.log(resultado["COUNT(*)"]);
    		response.send(resultado["COUNT(*)"]);
  		} catch (err) {
    	console.error(err);
  		} finally {
    	if (connection) {
      	try {
        	await connection.close();
      	} catch (err) {
        	console.error(err);
      	}
    	}
  		}
		response.end();
	} else {
		response.send('No has agregado usuario y contraseña');
		response.end();
	}
});

app.listen(8000,function(){
  console.log('Servidor Web - http://localhost:8000');
});


function error(err,rs,cn){
  if(err){
    console.log(err.message);
    if(cn!=null) close (cn);
    return -1;
  }
  else
    return 0;
}


//////
/////
////
////
/////



