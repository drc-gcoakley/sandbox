@echo off
rem Can try adding  -noreloading  if grails is acting funny
rem or run:
rem   grails clean %*
rem   grails refresh-dependencies %*
rem It is recommended that a clean re run before tests
rem   grails -clean test-app %*

echo. | time

grails --plain-output --stacktrace test-app %*

echo "To run only certain typeof tests pass 1+ of the arguments "
echo "   including the trailing colon:  iat-test unit: functional: integration: "
echo "   (There are currently no functional tests.)"

echo. | time
echo | time
