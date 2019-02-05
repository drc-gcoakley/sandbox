@echo off

call importExportMongoConfig.cmd

echo "ABOUT TO IMPORT from %FromDB% to %ToDB%"
pause
(
  for %%i in (%collectionList%) do (
    mongoimport --db %ToDb% --collection %%i --upsert --file %TempDir%\%%i.json --host %ToServer% --port %ToPort%
    if ERRORLEVEL 1 goto end
  )
)
echo "IMPORTING complete."
pause
