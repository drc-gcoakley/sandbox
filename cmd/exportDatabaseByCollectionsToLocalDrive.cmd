@echo off

rem COMMON VARIABLES TO EDIT are in importExportMongoConfig.cmd
call importExportMongoConfig.cmd

REM modify the collectionList to only pull the data you need - good for refreshing stale data in only collections that have changed.
set collectionList=form testSession administration announcement deleted image program programSequences role role.next_id studentGroup trackLog user user.next_id userToken userToken.next_id

echo "ABOUT TO EXPORT from %FromDB% to %ToDB%"

set /p PRODPASS="Enter the Production Password: "
set FromPass=%PRODPASS%

echo Running on each collection: mongoexport --db %FromDB% --collection %%i --out %TempDir%\%%i.json -u %FromUserId% -p {PASSWORD} --host %FromServer% --port %FromPort%

for %%i in (%collectionList%) do (
  mongoexport --db %FromDB% --collection %%i --out %TempDir%\%%i.json -u %FromUserId% -p %FromPass% --host %FromServer% --port %FromPort%
  if ERRORLEVEL 1 goto end
)

echo "EXPORTING complete."
dir %TempDir%
