call :LOG > autocommit_output.log
exit /B

:LOG
for /f "delims=" %%f in ('dir /b /o-d ".\archivedData\"') do set latest_file=.\archivedData\%%f & goto Weiter
ECHO No file found!
GOTO :EOF

:Weiter
copy %latest_file% .\data\latest_copy.csv
del /f .\data\IHKBerlin_Gewerbedaten.csv
move .\data\latest_copy.csv .\data\IHKBerlin_Gewerbedaten.csv
git add -u ".\data\IHKBerlin_Gewerbedaten.csv"
git commit -m "Aktuelles Dataset"
git push origin master --force --tags
git add ".\archivedData\*.csv"
git commit -m "Neues Dataset"
git push origin master --force --tags