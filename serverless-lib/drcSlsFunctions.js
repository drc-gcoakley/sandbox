/*
const fs = require('fs');
const path = require('path');
const AWS = require('aws-sdk');

const awsSts = new AWS.STS();
*/

/**
 * Generate an AMI name composed of the date and the repo name
 * @return {String} AMI name
 */
module.exports.todayAsIsoString = () => {
  //return { nested: 'TODAY' }; //`${new Date().toISOString().replace(/-/g, '').substring(0, 8)}`;
  return 'TODAY'; //`${new Date().toISOString().replace(/-/g, '').substring(0, 8)}`;
};

/*
module.exports = {
	todayAsIsoString
};
*/
