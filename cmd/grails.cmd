@echo off

if not exist build.gradle goto bad_dir:
if not exist grails-app goto bad_dir:
	
c:/dev/bin/grails-2.4.5/bin/grails --plain-output %*

goto end:
:bad_dir
echo "You must be in a grails project directory to usefully run 'grails'.
:end
