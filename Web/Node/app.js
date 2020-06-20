var http = require('http');
var fs = require('fs');
var oracledb = require('oracledb');

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function run() {

  let connection;
  try {
    connection = await oracledb.getConnection(  {
      user          : "CG_PROY_ADMIN",
      password      : "samjor",
      connectString : "cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com:1521/SCOOTERS"
    });

    const result = await connection.execute(
      `SELECT ZONA_ID, NOMBRE,POLIGONO
       FROM zona
       WHERE zona_id = :id`,
      [12],
    );
    console.log(result.rows);

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
}

fs.readFile('./index.html', function (err, html) {
    if (err) {
        throw err; 
    }       
    http.createServer(function(request, response) {  
        response.writeHeader(200, {"Content-Type": "text/html"});  
        response.write(html);  
        response.end();  
    }).listen(8000);
});

run();
