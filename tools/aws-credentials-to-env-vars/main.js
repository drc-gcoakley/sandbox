let fs = require('fs');
let parser = require('@yaas/iniparser');

let iniBody = fs.readFileSync(process.env.HOME + '/.aws/credentials', 'utf8');
let iniJson = parser.parse(iniBody, '\n');
let drcCred = iniJson['177429746880_AWS-SSO-Developers'];

for (let k of Object.keys(drcCred)) {
  console.log(`export ${k.toLocaleUpperCase()}=${drcCred[k]}`);
}
