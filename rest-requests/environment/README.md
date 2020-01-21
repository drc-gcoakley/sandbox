## About
The 'rest-requests' directory tree includes scripts for Intellij's 'http-client' to use in making requests to the various RTM endpoints. http-client is a default plugin shipped with IDEA, that provides functionality much like Postman but without a slow, clunky interface. 

Ref: https://www.jetbrains.com/help/idea/2019.1/testing-restful-web-services.html

The response handling code in these files is written in ECMAScript 5.1: https://www.ecma-international.org/ecma-262/5.1/

### Notes
I expected the following to work when given as a request body from a .json file and fed into the request using redirection.  But, since ECA returned '403 forbidden' when I tried this, I conclude that variables are not expanded in in request bodies read from files.

  eca-login.json:
   
     { "username": "{{ecaUsername}}", "password": "{{ecaPassword}}" }
     
  Would then use this in a script as the request body:
     
     < ./environment/eca-login.json

If all credentials were identical for each environment then the above variable expansion would not be needed. Allowing for different credentials in different  

To account for using different ECA credentials in the different environments the whole JSON body of the ECA /authenticate request is placed in variable  "ecaCredentialsJson" which is defined in rest-client.private.env.json. Please note the escaped quotes. (It may be possible to use single quotes.)
