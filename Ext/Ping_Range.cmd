@echo off
setlocal enabledelayedexpansion
:Timeout for ping command in milliseconds
Set _t0=500

Set /P _t4=Enter Network Prefix (example 172.16.9.):
:start IP (last number)
Set /P_t1= Enter Firs Host IP (example 40):
:ending IP (last number)
Set /P _t2=Enter Last Host IP (example 99):

for /L %%I in (%_t1%,1,%_t2%) do set _t3=%%I & (ping %_t4%%%I -n 1 -w %_t0% >nul
) & call:_e!errorlevel!
Echo(
echo All IPs tested
pause
exit
:::::::::::::::::::::::::::::::::::::::::::::::::::
:clear the temp variables that were used
:::::::::::::::::::::::::::::::::::::::::::::::::::
for /L %%I in (0,1,4) do set _t%%I=
goto:eof
:::::::::::::::::::::::::::::
:End of main
:::::::::::::::::::::::::::::
:Subroutines Below here
:::::::::::::::::::::::::::::::::::::::::::::::::::
:Enter code to execute if the IP address is present in this section
:::::::::::::::::::::::::::::::::::::::::::::::::::
:_e0
echo %_t4%%_t3% exists
REM nslookup %_t4%%_t3%
 goto:eof
:::::::::::::::::::::::::::::::::::::::::::::::::::
:Enter code to execute if the IP address is not present in this section
:::::::::::::::::::::::::::::::::::::::::::::::::::
:_e1
Echo %_t4%%_t3% does not exist
goto:eof
