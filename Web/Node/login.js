var oracledb = require("oracledb");
var express = require("express");
var app = express();
var bodyParser = require("body-parser");
var methodOverride = require("method-override");
var peticion = require("./responseORCL");
var path = require('path');

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

var app = express();
app.use(session({
	secret: 'proyectoBD',
	resave: true,
	saveUninitialized: true
}));

app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());

app.get('/', function(request, response) {
	response.sendFile(path.join(__dirname + '/login.html'));
});

app.post('/auth', function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		connection.query('SELECT * FROM accounts WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.username = username;
				response.redirect('/home');
			} else {
				response.send('Incorrect Username and/or Password!');
			}			
			response.end();
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});

app.get('/home', function(request, response) {
	if (request.session.loggedin) {
		response.send('Welcome back, ' + request.session.username + '!');
	} else {
		response.send('Please login to view this page!');
	}
	response.end();
});

app.listen(3000);