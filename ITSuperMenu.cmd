REM #########################################################################

REM IT Super Menu By Haim Cohen 2014 v3.7
REM Feedback : http://il.linkedin.com/in/haimc
REM Blog: http://blogs.microsoft.co.il/skepper/

REM #########################################################################
:SETTEMPDIR
REM Set Temp directory for reporting.
IF EXIST C:\ITSuperMenu_Temp GOTO SETTOOLS
:MAKEDIR
MD C:\ITSuperMenu_Temp

:SETTOOLS
REM Set Root directory of IT Super Menu (Example: C:\ITSupportMenu)
cls
@ECHO off
SET TOOLS=%~dp0


:SETCONSOLE
mode con: cols=100 lines=50
type  %TOOLS%\Ext\ASCII\First_ASCII.txt   
Echo(
Echo(

:setuser
SET /P TRYAGAIN=Start "IT Super Menu" as %USERDOMAIN%\%username% ([Y]/N)?
IF /I "%TRYAGAIN%" NEQ "N" GOTO start

:Credentials
Echo(
Echo Please Enter Credentials to use for IT Super Menu (DOMAIN\USER):
SET /P FUID= 
runas /noprofile /user:%FUID% "%TOOLS%\ITSuperMenu.cmd"
IF NOT %ERRORLEVEL% == 0 GOTO suerror1
exit

:suerror1
cls
color 0c
echo ==================================
SET /P TRYAGAIN=Logon failure, Try again (Y/[N])?
IF /I "%TRYAGAIN%" NEQ "Y" GOTO start
goto Credentials


:unknowerror
msg * /TIME:3 "Sorry, unknow error, Please contact Haim Cohen"
goto start


REM ########################################################################################
:start
title IT Super Menu by Haim Cohen 2014 ::::::: Workning Directory: %CD% ::::::: %date% %TIME:~0,2%:%TIME:~3,2%
color 0a
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO( 	
ECHO( [%date% %TIME:~0,2%:%TIME:~3,2%]    [Current Session User: %USERDOMAIN%\%username%]    [Managed System is: %IP%]
Echo( ______________________________________________________________________________________________
Echo( 
ECHO 1.  Ping, and Ping a Range.
ECHO 2.  Nslookup.
ECHO 3.  RDP (MSTSC).
ECHO 4.  Port Query.
Echo 5.  Tracert
Echo 6.  PuTTY (SSH and Telnet Client).
Echo 7.  Task List and Task Kill Remote Computer.
Echo 8.  Services Remote Computer.
Echo 9.  Computer Management Remote Computer.
Echo 10. Command Line Remote Computer (PsExec).
Echo 11. GPUpdate Remote Computer (PsExec).
Echo 12. Get Serial and Manufacturer on Remote Computer.
Echo 13. VNC Viewer.
Echo 14. Documenting Remote Computer.
Echo 15. Get List Printers on Remote Computer.
Echo 16. Rename Computer Name Remotely.
Echo 17. User Info (domain user).
Echo 18. Remote Logged Users, Sessions Query and Logoff.
ECHO 19. Get Windows Updates Installed on Remote Computer.
Echo 20. Get List Devices drivers on Remote Computer.
Echo 96. Open Powershell Console.
Echo 97. Open CMD Console.
Echo 98. Restart Remote Computer
Echo(
Echo SU. Run IT Super Menu as other user.
ECHO G.  Open Google.com.
ECHO X.  Exit.
ECHO(
set /p choice=Please Enter Command Number:
REM if not '%choice%'=='' set choice=%choice:~0;1% ( don`t use this command, because it takes only first digit in the case you type more digits. After that for example choice 23455666 is choice 2 and you get "bye"

if '%choice%'=='' ECHO "%choice%" is not valid please try again
if '%choice%'=='1' goto step1
if '%choice%'=='2' goto step2
if '%choice%'=='3' goto step3
if '%choice%'=='4' goto step4
if '%choice%'=='5' goto step5
if '%choice%'=='6' goto step6
if '%choice%'=='7' goto step7
if '%choice%'=='8' goto step8
if '%choice%'=='9' goto step9
if '%choice%'=='10' goto step10
if '%choice%'=='11' goto step11
if '%choice%'=='12' goto step12
if '%choice%'=='13' goto step13
if '%choice%'=='14' goto step14
if '%choice%'=='15' goto step15
if '%choice%'=='16' goto step16
if '%choice%'=='17' goto step17
if '%choice%'=='18' goto step18
if '%choice%'=='19' goto step19
if '%choice%'=='20' goto step20
if '%choice%'=='96' goto step96
if '%choice%'=='97' goto step97
if '%choice%'=='98' goto step98
if '%choice%'=='g' Start http://www.Google.com
if '%choice%'=='x' goto stepx
if '%choice%'=='su' goto stepsu
if '%choice%'=='EDIT' goto edit
if '%choice%'=='EDIT+' goto edit2
if '%choice%'=='..' start explorer %TOOLS%


ECHO(
goto start
REM ########################################################################################

:step1
REM Ping and Ping Range
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command : Ping
echo(

:pingtype
SET /P PINGTYPE=Ping Rang of IP (y/[n]) ?
IF /I "%PINGTYPE%" NEQ "y" GOTO oneping

:rangping
start %TOOLS%\Ext\Ping_Range.cmd
goto start

:oneping
Echo Selected Command : Ping
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter new IP or Hostname (or any key to manage %IP%):
echo(
set /P IP=
IF "%IP%"=="" (ECHO You must enter an IP address or hostname) ELSE (GOTO nextstep)
pause
goto oneping

:nextstep
REM SET /P LIMIT4=Limit to IPv4? (-4) ([y]/n)
REM IF /I "%LIMIT4%" NEQ "n" (SET PINGSWITCH=-a -4) ELSE (SET PINGSWITCH=-a)
SET PINGSWITCH=-a -4

SET /P PINGCONT=Use continuous Ping? (-t) (y/[n])
IF /I "%PINGCONT%" NEQ "y" (SET CONTSWITCH=) ELSE (SET CONTSWITCH=-t)
ping %PINGSWITCH% %IP% %CONTSWITCH%
pause
goto start


REM ########################################################################################
:step2
REM Nslookup
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command : Nslookup
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
nslookup %IP%
pause
goto start

REM ########################################################################################
:step3
REM RDP
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: RDP
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
ECHO(

SET /P ADMIN=Connect as /Admin? ([y]/n)
IF /I "%ADMIN%" NEQ "n" (SET MSTSCSWITCH=/admin) ELSE (SET MSTSCSWITCH=)

echo Connecting to %IP%
START mstsc %MSTSCSWITCH% /v %IP%
goto start

REM ########################################################################################
:step4
REM Port Query
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Port Query
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
:portid
Echo Enter port(s) to query (valid range: 1-65535):
Echo Separate multiple ports with a comma (80,3389,445)
Echo(
SET /P PORT=
%TOOLS%\Ext\portqry.exe -n %IP% -o %PORT% | findstr TC*
Echo(
SET /P QUERYAGAIN=Query anther Port (y/[n])?
IF /I "%QUERYAGAIN%" NEQ "y" GOTO start
goto portid

REM ########################################################################################
:step5
REM Tracert
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command:Tracert
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
tracert -d %IP%
pause
goto start

REM ########################################################################################

:step6
REM PuTTY SSH and Telnet Client
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: PuTTY
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
:puttyhome
Echo =========================================
@CHOICE /C:TSC /M "Select: Telnet, SSH or Cancel"
IF ERRORLEVEL 3 GOTO CANCEL
IF ERRORLEVEL 2 GOTO SSH
IF ERRORLEVEL 1 GOTO TELNET
GOTO end
:TELNET
cls
Echo(
ECHO You have select "TELNET"
START %TOOLS%\Ext\PuTTY\putty.exe -telnet %IP%
GOTO CANCEL
:SSH
cls
Echo(
ECHO You have select "SSH"!
START %TOOLS%\Ext\PuTTY\putty.exe -ssh %IP%
GOTO CANCEL
:CANCEL
goto start

REM ########################################################################################

:step7
REM Task List and Task Kill
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Task List and Task Kill Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
Tasklist /s "%IP%"
ECHO(
Pause
echo(
SET /P AREYOUSURE=Do you want to kill any Process ? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
echo Enter Process ID (PID)
echo(
set /P PID=
echo Kill Remote Machine, Spinning Process, Please wait...
taskkill /s %IP% /PID %PID%
pause
goto start
pause
:END
endlocal
goto start

REM ########################################################################################

:step8
REM Services
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Services Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
START services.msc /computer:%IP%
goto start

REM ########################################################################################

:step9
REM Computer Management on a Remote Computer
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Computer Management on a Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
START compmgmt.msc /computer:%IP%
goto start

REM ########################################################################################

:step10
REM Command Prompt
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Open Command Prompt on a Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
:psexechome
Echo ==========================================================
@CHOICE /C:YNC /M "Login to remote computer with current user? (Yes/No/Cancel)"
IF ERRORLEVEL 3 GOTO CANCEL
IF ERRORLEVEL 2 GOTO setno
IF ERRORLEVEL 1 GOTO setyes
GOTO end
:setyes
cls
start %TOOLS%\ext\PSTools\psexec.exe \\%IP% cmd 
GOTO CANCEL
:setno
cls
Echo(
ECHO Enter DOMAIN\USER:
set /p altuser=
start %TOOLS%\ext\PSTools\psexec.exe -u %altuser%  \\%IP% cmd 
GOTO CANCEL

:CANCEL

goto start

REM ########################################################################################

:step11
REM GPUpdate /Force
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: GPUpdate /Force Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
:psexechome
Echo ==========================================================
@CHOICE /C:YNC /M "Login to remote computer with current user? (Yes/No/Cancel)"
IF ERRORLEVEL 3 GOTO CANCEL
IF ERRORLEVEL 2 GOTO setno
IF ERRORLEVEL 1 GOTO setyes

GOTO end
:setyes
cls
start %TOOLS%\ext\PSTools\psexec.exe \\%IP% gpupdate /force
GOTO CANCEL
:setno
cls
Echo(
ECHO Enter DOMAIN\USER:
set /p altuser=
start %TOOLS%\ext\PSTools\psexec.exe -u %altuser%  \\%IP% gpupdate /force 
GOTO CANCEL

:CANCEL
goto start

REM ########################################################################################

:step12
REM Get Serial and Manufacturer on Remote Computer
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Get Serial and Manufacturer on Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
ECHO(
wmic /node:"%IP%" bios get Manufacturer, serialnumber, Status 
wmic /node:"%IP%" bios get Manufacturer, serialnumber, Status >>C:\ITSuperMenu_Temp\%IP%_%date%_Manufacturer_Serial.txt
START notepad C:\ITSuperMenu_Temp\%IP%_%date%_Manufacturer_Serial.txt
ECHO(
goto start

REM ########################################################################################

:step13
REM VNC
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: VNC Viewer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
START %TOOLS%\Ext\vnc.exe %IP%
goto start

REM ########################################################################################

:step14
REM Inventory and documenting Remote Computer - Full
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Inventory and documenting Remote Computer
echo(
Echo Please Note: Microsoft Word Must be installed on current computer!
echo(
echo Currenet Managed System: %IP%
echo(
ECHO Enter IP or Hostname:
SET /P IP=

:DOCUMENTINGOPTION
ECHO Do you want [F]ull reporting or [M]inimal reporting? ([f]/m)
SET /P DOCUMENTINGOPTIONQ=
IF /I "%DOCUMENTINGOPTIONQ%" NEQ "m" SET DOCUMENTINGOPTIONA=-wabefghipPqrsu -racdklp
IF /I "%DOCUMENTINGOPTIONQ%"=="m" SET DOCUMENTINGOPTIONA=-w -r

cscript %TOOLS%\Ext\sydi\sydi-server.vbs %DOCUMENTINGOPTIONA% -racdklp -ew -f10 -d -t%IP%
IF NOT %ERRORLEVEL% == 0 GOTO unknowerror

goto start

REM ########################################################################################

:step15
REM Get List Printers on Remote Computer.
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Get List Printers on Remote Computer.
echo(
echo Currenet Managed System: %IP%
echo(
ECHO Enter IP or Hostname:
echo(
set /P IP=
echo Please wait...
WMIC /Node:"%IP%" Path Win32_Printer Get DeviceID, DriverName, PortName, SystemName, ShareName, ServerName, Default >>C:\ITSuperMenu_Temp\%IP%_%date%_Printers.txt
IF NOT %ERRORLEVEL% == 0 GOTO unknowerror
START notepad C:\ITSuperMenu_Temp\%IP%_%date%_Printers.txt
goto start


REM ########################################################################################

:step16
REM Rename Computer Name
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Rename Computer Name 
echo(
SET /P POLDC= TYPE IN THE OLD COMPUTER NAME:
SET /P PNEWC= TYPE IN THE NEW COMPUTER NAME:
SET /P UID= TYPE DOMAIN\USER:
REM SET /P PAS= TYPE PASSWORD:

SET /P REBOOTCOMP= Shall I also reboot the remote computer? ([y]/n)
IF /I "%REBOOTCOMP%" NEQ "n" SET REBOOTCOMP=/reboot

:nextstep
setlocal
color 1c
echo.
echo.
echo Computer %POLDC% will be renamed
IF /I "%REBOOTCOMP%" NEQ "n" ECHO and rebooted, all unsaved work may be lost.
echo.
SET /P AREYOUSURE=Are you sure (y/[n])?
IF /I "%AREYOUSURE%" NEQ "y" GOTO end
netdom renamecomputer %POLDC% /newname:%PNEWC% /userd:%UID% /passwordd:* /force %REBOOTCOMP%


:end
endlocal
goto start

REM ########################################################################################
:step17
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected command: User Info (domain user).
echo(
Echo Currenet Domain: %USERDOMAIN%
ECHO Please enter username only (User1, User2...)
SET /P ADUSER= ENTER USERNAME TO QUERY:
net user %ADUSER% /domain >C:\ITSuperMenu_Temp\%ADUSER%_%date%.txt
IF NOT %ERRORLEVEL% == 0 GOTO unknowerror
start notepad C:\ITSuperMenu_Temp\%ADUSER%_%date%.txt
goto start

REM ########################################################################################
:step18
REM Query Remote Sessions+ Logoff Remote Sessions
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command:Query Remote Sessions+ Log off Remote Sessions
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
quser /server:%IP%
echo(
echo Enter Sessions ID
echo(
set /P ID=
logoff /server:%IP% %ID% 
pause
goto start

REM ########################################################################################
:step19
REM  Get Windows Updates Installed on Remote Computer
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command:List Installed Windows Updates
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
echo Please wait...
wmic /node:"%IP%" QFE >C:\ITSuperMenu_Temp\%IP%_WinUpdates.txt
IF NOT %ERRORLEVEL% == 0 GOTO unknowerror
START notepad C:\ITSuperMenu_Temp\%IP%_WinUpdates.txt
ECHO(
goto start

REM ########################################################################################
:step20
REM Get List Devices drivers on Remote Computer
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
Echo Selected Command: Get List Devices drivers on Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
echo Please wait...
DRIVERQUERY /S %IP% /V /FO CSV >C:\ITSuperMenu_Temp\%IP%_Drivers.txt
IF NOT %ERRORLEVEL% == 0 GOTO unknowerror
START excel.exe C:\ITSuperMenu_Temp\%IP%_Drivers.txt
ECHO(
goto start

REM ########################################################################################
:step96
REM Open Powershell Console
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
start powershell
goto start

REM ########################################################################################

:step97
REM Open New CMD Console
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO(
start cmd /k "CD %windir%\SYSTEM32 & echo( & Echo This Console Running As: & WHOAMI"
goto start

REM ########################################################################################

:step98
REM Restart Remote Computer
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO( 	
echo(
Echo Selected Command: Restart Remote Computer
echo(
echo Currenet Managed System: %IP%
echo(
echo Enter New IP/Hostname (or any key to manage %IP%):
echo(
set /P IP=
setlocal
:PROMPT
color 1c
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
echo Perform to Restart %IP%
shutdown /r /f /t 10 /m %IP%
pause

:END
endlocal
goto start

REM ########################################################################################

:stepsu
REM Run this Menu as other user
cls
Type  %TOOLS%\Ext\ASCII\Main_Menu_ASCII.txt
ECHO( 	
color 0a
Echo(
Echo Run IT Super Menu as other user.
Echo(
SET /P SUID= TYPE DOMAIN\USER:
runas /noprofile /user:%SUID% "%TOOLS%\ITSuperMenu.cmd"
echo(
IF NOT %ERRORLEVEL% == 0 GOTO suerror
exit

:suerror
cls
echo(
color 0c
SET /P TRYAGAIN=Logon failure, Try again (Y/[N])?
IF /I "%TRYAGAIN%" NEQ "Y" GOTO END
goto stepsu

:END
goto start


REM ########################################################################################

:stepx
REM Exit
msg * /TIME:2 "Thank you for using this tool, Haim Cohen."
exit

REM ########################################################################################
:edit
start notepad %TOOLS%\ITSuperMenu.cmd
goto start

:edit2
start notepad++ %TOOLS%\ITSuperMenu.cmd
goto start
