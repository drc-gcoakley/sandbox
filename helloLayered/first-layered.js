'use strict';
let cv = require('opencv4nodejs');

module.exports.goServerless = async event => {
	const rect = cv.Rect(60, 1562, 40, 40);
	console.log(JSON.stringify(rect, null, 2));
		
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'go-serverless: Successfully invoked OpenCV and Tesseract.',
        input: event,
      },
      null,
      2
    ),
  };

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
