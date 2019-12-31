// const fs = require('fs');
// const path = require('path');
const AWS = require('aws-sdk');


const awsSts = new AWS.STS();


/**
 * Generate an AMI name composed of the date and the repo name
 * @return {String} AMI name
 */
function todayAsIsoString() {
  return 'TODAY'; //`${new Date().toISOString().replace(/-/g, '').substring(0, 8)}`;
}

async function getAccountId() {
  // Checking AWS user details
  const { Account } = await awsSts.getCallerIdentity().promise();
  return Account;
}

module.exports = {
	getAccountId,
	todayAsIsoString,
};
