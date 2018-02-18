REM /////////////////////////////////////////////////////////////////////////
REM
REM -------------------------------------------------------------------------
REM  File name:   build.bat
REM  Version:     v1.00
REM  Created:     29/3/2014 by Kevin.
REM  Description: Call clean.bat and build.sh
REM -------------------------------------------------------------------------
REM  History:
REM
REM /////////////////////////////////////////////////////////////////////////

@echo off

REM Check Cygwin path
if "%1" == "" (
	echo error build.bat: Need Cygwin path as argument!
	EXIT 1
)

if "%2" == "" (
	GOTO ThrowActionError	
)

if "%2" == "clean" (
	set action="%2"
	goto EverythingOK
)

if "%2" == "make" (
	set action="%2"
	goto EverythingOK
)

REM Action Error
:ThrowActionError
	echo "%2"
	echo error need action Type: clean, make!
	EXIT 1



:EverythingOK
	REM Variables
	set cygwin=%1 
	set projektDir=%cd%
	set bochsDir=%projektDir%\Bochs

	REM ++++++++++++++++++++++++++++ Run make in cygwin ++++++++++++++++++++++++++++
	%cygwin% --login -i -x -o igncr "%projektDir%\build.sh" %projektDir% %action% REM Not the best way to ignore windows cr

	if %action% == "clean" (
		goto Sucess
	)

	cd object_files/	
	copy /b boot.bin + kernel.bin IntoxOS.bin
	cd ..
	echo %cd%
	move object_files\IntoxOS.bin Bochs\IntoxOS.bin

	REM +++++++++++++++++++++++++++++ Run IntoxOS in Bochs +++++++++++++++++++++++++++++
	chdir /D %bochsDir%\
	bochs -q -f "bochsrc.bxrc"
	REM +++++++++++++++++++++++++++++ exit 0 for Visual Studio +++++++++++++++++++++++++++++
	:Sucess
		EXIT 0



