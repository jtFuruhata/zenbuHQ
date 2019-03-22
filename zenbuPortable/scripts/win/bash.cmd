@echo off
REM
REM 【 zenbuPortable 】 bash.cmd
REM   Ver1.00.190322a
REM Concepted by TANAHASHI, Jiro (aka jtFuruhata)
REM Copyright (C) 2019 jtLab, Hokkaido Information University
REM
REM The parental bash invoker from cmd.exe at zenbuPortable $HOME
REM e.g.
REM > bash          # start bash login shell in cmd.exe process
REM > bash -c "ls"  # run bash commands and return to cmd.exe process
REM
REM set MSYS2_PATH_TYPE=inherit
set MSYSTEM=MSYS
set HOME=%~dp0../..
call %HOME%\apps\win\msys64\usr\bin\bash.exe -l %*
