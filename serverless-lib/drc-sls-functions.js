// const fs = require('fs');
// const path = require('path');
const AWS = require('aws-sdk');
const Flatted = require('flatted/cjs');

const awsSts = new AWS.STS();

/**
 * Generate an AMI name composed of the date and the repo name
 * @return {String} AMI name
 */
function todayAsIsoString() {
    return new Date().toISOString().replace(/-/g, '').substring(0, 8);
}

/**
 * Generate an AMI name composed of the date and the repo name
 * @return {String} AMI name
 */
function dumpServerlessConfig(serverlessConfig) {
    console.log("\n\nServerless configuration object:");
    console.log(Flatted.stringify(serverlessConfig, null, 3));
    console.log("\n\n");
    return ''; // MUST return a string.
}

async function getAccountId() {
  // Checking AWS user details
  const { Account } = await awsSts.getCallerIdentity().promise();
  return Account;
}

module.exports = {
	getAccountId,
	todayAsIsoString,
    dumpServerlessConfig,
};
