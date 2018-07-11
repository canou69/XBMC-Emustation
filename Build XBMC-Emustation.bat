:: Copyright of John Conn (Rocky5 Forums & JCRocky5 Twitter) 2016
:: Please don't re-release this as your own, if you make a better tool then I don't mind :-)
Attrib /s -r -h -s "Thumbs.db" >NUL
Del /Q /S "Thumbs.db" 2>NUL
:Start
@Echo off & SetLocal EnableDelayedExpansion & Mode con:cols=100 lines=10 & Color 0B
title XBMC-Emustation Builder

if exist "XBMC" Set "foldername=XBMC"
if exist "Build" Set "foldername=Build"
if not exist "%foldername%" (
	Echo Error, place a fresh copy of XBMC next to this batch file and try again.
	timeout /t 5
	Exit
)
Set "fromDate=06/07/2018"
Set "toDate=%date%"
Set "version=1.1"
(
echo fromDate^=CDate^("%fromDate%"^)
echo toDate^=CDate^("%toDate%"^)
echo WScript.Echo DateDiff^("d",fromDate,toDate,vbMonday^)
)>tmp.vbs
for /f %%a in ('cscript /nologo tmp.vbs') do (
if %%a GEQ 100 Set "daytotal=%%a"
if %%a LSS 100 Set "daytotal=0%%a"
if %%a LSS 10 Set "daytotal=00%%a"
)
del tmp.vbs
cls
Echo: & Echo: & Echo: & Echo   Please wait...

(
rd /q /s "%foldername%\plugins"
rd /q /s "%foldername%\sounds"
rd /q /s "%foldername%\userdata"
rd /q /s "%foldername%\visualisations"
rd /q /s "%foldername%\web"
rd /q /s "%foldername%\system\keymaps"
rd /q /s "%foldername%\system\cdrip"
rd /q /s "%foldername%\system\scrapers"
rd /q /s "%foldername%\system\players\mplayer\codecs"
del /q /s "%foldername%\copying.txt"
del /q /s "%foldername%\keymapping.txt"
del /q /s "%foldername%\media\icon.png"
del /q /s "%foldername%\media\Splash_2007.png"
del /q /s "%foldername%\media\Splash_2008.png"
del /q /s "%foldername%\media\weather.rar"
rd /q /s "%foldername%\skin"
rd /q /s "%foldername%\scripts"
rd /q /s "%foldername%\screensavers"
move "%foldername%\media" "%foldername%\system\"
move "%foldername%\language" "%foldername%\system\"
move "%foldername%\media" "%foldername%\system\"
move "%foldername%\screenshots" "%foldername%\system\"
move "%foldername%\UserData" "%foldername%\system\"

XCopy /s /e /i /h /r /y "Mod Files" "%foldername%"
XCopy /s /i /h /r /y "Emu xbe files" "%foldername%\.emustation\emulators"
del /q /s "%foldername%\.emustation\emulators\*.bat"
del /q /s "%foldername%\.emustation\emulators\place emulators files in here"
del /q "%foldername%\.emustation\emulators\*.info"
del /q /s "%foldername%\.emustation\roms\roms go here"
del /q /s "%foldername%\.emustation\media\media goes here"
rd /q /s "%foldername%\.emustation\scripts\not used"
rd /q /s "%foldername%\default skin\media\Use for custom home layouts"
copy /y "Changes.txt" "%foldername%"
if exist "..\Other\build for release" (
	Call Other\Tools\repl.bat "XBMC-Emustation 0.0.000" "XBMC-Emustation %version%.%daytotal%" L < "%foldername%\default skin\language\English\strings.po" >"%foldername%\default skin\language\English\strings.tmp"
	Del "%foldername%\default skin\language\English\strings.po"
	rename "%foldername%\default skin\language\English\strings.tmp" "strings.po"
	Call Other\Tools\repl.bat "	" "" L < "%foldername%\changes.txt" >"%foldername%\changes.tmp"
	copy /b "Other\Tools\Changes\Changes_Header.xml"+"%foldername%\changes.tmp"+"Other\Tools\Changes\Changes_Footer.xml" "%foldername%\default skin\720p\Custom_Changes.xml"
	del /q "%foldername%\changes.tmp"
)
del /Q "%foldername%\Changes.txt"
copy /y "New XBMC xbe\default.xbe" "%foldername%\default.xbe"
ren "%foldername%" "XBMC-Emustation"
)
cls
Echo:
Echo: & Echo: & Echo: & Echo   Done...
timeout /t 3 >NUL