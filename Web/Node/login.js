//VARIABLES REQUERIDAS

var oracledb = require("oracledb");
var express = require("express");
var app = express();
var session = require('express-session');
var bodyParser = require("body-parser");
var methodOverride = require("method-override");
var peticion = require("./responseORCL");
var path = require('path');
var md5 = require('md5');

//MÉTODOS DE UTILIZACIÓN DE CALLBACKS
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(methodOverride());
app.use(bodyParser.raw());
app.use(bodyParser.text());
app.use(express.static('public'));

app.use(session({
	secret: 'proyectoBD',
	resave: true,
	saveUninitialized: true,
	cookie: { maxAge: 300000 }
}));
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;
oracledb.autoCommit = true;
//ELEMENTO DE CONEXIÓN PARA CONEXIONES ASÍNCRONAS
connection = {
      user          : "CG_PROY_ADMIN",
      password      : "samjor",
      connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
}

//GETS DE ANTES DEL INICIO DE SESIÓN

app.get('/', function(request, response) {
	response.sendFile(path.join(__dirname + '/IniciarSesion.html'));
});

app.get('/ubicacion',function(request,response){
	response.sendFile(path.join(__dirname+'/Ubicacion.html'))
})

app.get('/dashboard', function(request, response) {
	session = request.session;


	response.sendFile(path.join(__dirname + '/dashboard.html'));
});


app.get('/registro', function(request, response) {
	response.sendFile(path.join(__dirname + '/Registro.html'));
});


app.get('/olvido', function(request, response) {
	response.sendFile(path.join(__dirname + '/Olvido.html'));
});


//POST PARA INICIO DE SESIÓN
app.post('/auth', async function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		sql = "SELECT COUNT(*) AS USUARIO FROM USUARIO WHERE EMAIL = '"+username+"' AND PASSWORD = '"+md5(password)+"'";
		console.log(sql);
		try {
			connection =  await oracledb.getConnection(  {
     		user          : "CG_PROY_ADMIN",
      		password      : "samjor",
  			connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
		});
			const result = await connection.execute(sql);
			const resultado = result.rows[0]['USUARIO'];
			if (resultado == 1) {
				request.session.loggedin = true;
				request.session.username = username;
				response.redirect('/dashboard');
			}else{
				response.redirect('/');
			}
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
		response.redirect('/');
		response.end();
	}
});

app.post('/signUp', async function(request, response) {
	var username = request.body.correo;
	var contrasena = request.body.contrasena;
	var nombre = request.body.nombreusuario;
	var ap_mat = request.body.apMat;
	var ap_pat = request.body.apPat;
	if (username && contrasena) {
		sql = "SELECT COUNT(*) AS USUARIO FROM USUARIO WHERE EMAIL = '"+username+"'";
		console.log(sql);
		try {
			connection =  await oracledb.getConnection(  {
     		user          : "CG_PROY_ADMIN",
      		password      : "samjor",
  			connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
		});
		connection2 =  await oracledb.getConnection(  {
			user          : "CG_PROY_ADMIN",
			 password      : "samjor",
			 connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
	   });

			const result = await connection.execute(sql);
			const resultado = result.rows[0]['USUARIO'];
			if (resultado == 1) {
				console.log('No puedes registrar ese usuario, ya existe en la base');
				response.redirect('/registro');
			}else{
				var sqlInsert = "INSERT INTO USUARIO VALUES (SEQ_USUARIO.NEXTVAL,'"+username+"','"+nombre+"','"+ap_pat+"','"+ap_mat+"','"+md5(contrasena)+"',0)";
				console.log(sqlInsert);
				await connection2.execute(sqlInsert,{},{autoCommit:true},
					function (err, result) {
					if (err) {
						console.error(err.message);
						return;
					}
					response.redirect('/');
					return
					});
			}
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
		response.redirect('/');
		response.end();
	}
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

app.listen(8000,function(){
	console.log('Servidor Web - http://localhost:8000');
  });

//////
/////
////
////
/////



