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

REM +++++++++++++++++++++++++++++ Set Variables +++++++++++++++++++++++++++++
set cygwin=%1 
set projektDir=%cd%
set builderDir=%projektDir%\Builder
set kernelDir=%projektDir%\Kernel
set sourceDir=%kernelDir%\Source
set bochsDir=%projektDir%\Bochs
set bootloaderDir=%projektDir%\Bootloader


REM +++++++++++++++++++++++++++++ Clean directories +++++++++++++++++++++++++++++
REM call %builderDir%/clean.bat REM Should update with make clean !!!

REM ++++++++++++++++++++++++++++ Compile with cygwin ++++++++++++++++++++++++++++
cd Builder
%cygwin% --login -i -x -o igncr "%builderDir%\build.sh" %projektDir% REM Not the best way to ignore windows cr


REM +++++++++++++++++++++++++++++ Move to Bochs directory +++++++++++++++++++++++++++++
cd ..
move Builder\IntoxOS.bin Bochs\IntoxOS.bin

REM +++++++++++++++++++++++++++++ Run IntoxOS in Bochs +++++++++++++++++++++++++++++
chdir /D %bochsDir%\
bochs -q -f "bochsrc.bxrc"

REM +++++++++++++++++++++++++++++ exit 0 for Visual Studio +++++++++++++++++++++++++++++
EXIT 0




