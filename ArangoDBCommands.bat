@echo off

rem ******************  MAIN CODE SECTION
set STARTTIME=%TIME%

rem Your code goes here (remove the ping line)

arangoimp --server.username "root" --server.password "gidisunju" --server.database "gidisunju" --server.request-timeout 3600 --collection "users" --file "C:\Users\sanex\ArangoDBResource\users.csv" --type "csv" --translate "id=_key" --progress true
rem arangoimp --server.username "root" --server.password "gidisunju" --server.database "gidisunju" --server.request-timeout 3600 --collection "destino" --file "C:\Users\sanex\ArangoDBResource\destino.csv" --type "csv" --translate "id=_key" --progress true
arangoimp --server.username "root" --server.password "gidisunju" --server.database "gidisunju" --server.request-timeout 3600 --collection "friends" --create-collection-type "edge" --file "C:\Users\sanex\ArangoDBResource\friends.csv" --type "csv" --translate "from=_from" --translate "to=_to" --from-collection-prefix "users" --to-collection-prefix "users" --progress true

set ENDTIME=%TIME%

rem ******************  END MAIN CODE SECTION


rem Change formatting for the start and end times
for /F "tokens=1-4 delims=:.," %%a in ("%STARTTIME%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

for /F "tokens=1-4 delims=:.," %%a in ("%ENDTIME%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

rem Calculate the elapsed time by subtracting values
set /A elapsed=end-start

rem Format the results for output
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %hh% lss 10 set hh=0%hh%
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%

set DURATION=%hh%:%mm%:%ss%,%cc%

echo.
echo Start    : %STARTTIME%
echo Finish   : %ENDTIME%
echo          ---------------
echo Duration : %DURATION% 
echo.

pause