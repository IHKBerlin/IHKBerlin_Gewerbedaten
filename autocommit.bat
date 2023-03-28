call :LOG > autocommit_output.log
exit /B

:LOG
for /f "delims=" %%f in ('dir /b /o-d ".\archivedData\"') do set latest_file=.\archivedData\%%f & goto Weiter
ECHO No file found!
GOTO :EOF

:Weiter
copy %latest_file% .\data\latest_copy.csv
del /f .\data\OD_IHK-Berlin.csv
move .\data\latest_copy.csv .\data\OD_IHK-Berlin.csv
git add -u ".\data\OD_IHK-Berlin.csv"
REM git commit -m "Aktuelles Dataset"
REM git push origin master --force --tags
git add ".\archivedData\*.csv"
git commit -m "Neues Dataset"
git push origin master --force --tags