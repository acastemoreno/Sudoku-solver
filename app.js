var express = require('express');
var app = express();
require('shelljs/global');

app.get('/rest/:on/:tw/:th/:fo/:fi/:si/:se/:ei/:ni', function(req, res) {
var text = exec('./sudokuexe ' + req.params.on + ' ' + req.params.tw + ' ' + req.params.th + ' ' + req.params.fo + ' ' + req.params.fi + ' ' + req.params.si + ' ' + req.params.se + ' ' + req.params.ei + ' ' + req.params.ni, {silent:true}).output;
res.json(text);
});

app.get('/', function(req, res) {
  res.type('text/plain'); // set content-type
  res.send('i am a beautiful butterfly'); // send text response
});

app.listen(process.env.PORT || 4730);
