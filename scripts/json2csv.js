// parseline.js process lines one by one
'use strict';
var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var headerLine = true;
var lineNumber = 1;

rl.on('line', function(line){
    var headers;
	lineNumber += 1;
	
	if (!line.match(/^[\s]*\/[\/\*].*//) {
		try {
			var obj = JSON.parse(line);
			var fields;
			
			if (headerLine) {
				headers = JSON.parse(line);
				headerLine = false;
			} else {
				// add the fields which you want to extract here:
				for (i = 0; i < headers.length; i++) {
					obj.data.headers[i] = headers[i];
					fields.push(obj.data.headers[i]);
				}
			}
			// print the fields, joined by a comma (CSV, duh.)
			// No escaping is done, so if the subject contains ',',
			// then you need additional post-processing.
			console.log(fields.join(','));
		
		} catch(Error e) {
			console.log ("Error at 1-based line: " + lineNumber);
		}
	}
});
