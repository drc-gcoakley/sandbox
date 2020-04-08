const ONE_MINUTE_IN_MILLIS = 60 * 1000;
var expireDate = new Date(0); // The 0 here is the key, which sets the date to the epoch
var epochtime = pm.environment.get("TokenExpires");

expireDate.setUTCSeconds(epochtime);
if ((!epochtime) || expireDate <= Date.now() + ONE_MINUTE_IN_MILLIS)	{
  const postRequest = {
    url: pm.environment.get("eca-security") + '/v0/authenticate',
    method: 'POST',
    header: {'Content-Type': 'application/json'},
    body: {
      mode: 'raw',
      raw: JSON.stringify({
        "username": pm.globals.get("eca-userName"),
        "password": pm.globals.get("eca-pw")
      })
    }
  };
  pm.sendRequest(postRequest, function (err, response) {
    body = response.json();
    postman.setEnvironmentVariable("Token", body.token);
    postman.setEnvironmentVariable("Authorization", "Bearer " + body.token);
    postman.setEnvironmentVariable("TokenExpires", body.expires);
  });
}
