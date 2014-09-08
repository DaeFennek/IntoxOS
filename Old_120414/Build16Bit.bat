REM /////////////////////////////////////////////////////////////////////////
REM
REM -------------------------------------------------------------------------
REM  File name:   build16Bit.bat
REM  Version:     v1.00
REM  Created:     29/3/2014 by Kevin.
REM  Description: build Bootloader -> Test for 8086 Assembly
REM -------------------------------------------------------------------------
REM  History:
REM
REM /////////////////////////////////////////////////////////////////////////

@echo off

REM Check Cygwin path
if "%1" == "" (
	echo error build16Bit.bat: Need Cygwin path as argument!
	EXIT 1
)

set cygwin=%1 
set projektDir=%cd%
set bochsDir=%projektDir%\Bochs
set bootloaderStage1Dir="%projektDir%\Bootloader\Stage 1"
set bootloaderStage2Dir="%projektDir%\Bootloader\Stage 2"
set builderDir=%projektDir%\Builder
set objDir=%projektDir%\object_files
REM +++++++++++++++++++++++++++++ Clean directories +++++++++++++++++++++++++++++
call %builderDir%/clean.bat REM Should update with make clean !!!

cd %bootloaderStage1Dir%
nasm -f bin loader.asm -o loader.bin
cd %bootloaderStage2Dir%
nasm -f bin loader2.asm -o %bootloaderStage1Dir%/loader2.bin

cd %bootloaderStage1Dir%
copy /b loader.bin + loader2.bin IntoxOS.bin


REM +++++++++++++++++++++++++++++ Move to Bochs directory +++++++++++++++++++++++++++++

move IntoxOS.bin %bochsDir%/IntoxOS.bin

REM move %objDir%\loader.bin %bochsDir%\IntoxOS.bin

REM +++++++++++++++++++++++++++++ Run IntoxOS in Bochs +++++++++++++++++++++++++++++
chdir /D %bochsDir%\
bochs -q -f "bochsrc.bxrc"

EXIT 0