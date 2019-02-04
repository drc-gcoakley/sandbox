rem Mongo must be running on your local machine.  Change the set statements as necessary.
rem
rem COMMON VARIABLES TO EDIT
rem

rem Data to transfer: lousiana or nebraska
set state=louisiana

rem Normally values for production and SQA/test.

rem Production Mongo hot-slave server
set prod_server_host=dcrmdbP007
set prod_user_id=%state%iatprod
set prod_db=%state%_iat_prod
rem SQA Mongo hot-slave server
set test_server_host=dcrmdbD005
set test_user_id=%state%iatdev
set test_db=%state%_iat_sqa


set   FromServer=%prod_server_host%
set   FromDB=%prod_db%
set   FromUserId=%prod_user_id%
rem   File name compatible date.
set   Today=2018-Jan-17
rem   Default is the same as the source database.
set   ToDB=%FromDB%

rem Should not need to changed anything past here.

set FromPort=31001
set TempDir=c:\temp\iat_data\%FromServer%.%FromDB%_on_%Today%
set ToServer=localhost
set ToPort=27017
set ToPass=falcon1
set ToUserId=%state%iatdev

REM modify the collectionList to only pull the data you need - good for refreshing stale data in only collections that have changed
set collectionList=form testSession administration announcement deleted image program programSequences role role.next_id studentGroup trackLog user user.next_id userToken userToken.next_id
