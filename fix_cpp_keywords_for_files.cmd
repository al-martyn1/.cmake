@echo off
@set FIX_CMD="%~dp0\fix_cpp_keywords.cmd"
@setlocal enabledelayedexpansion
:process_args
@if "%~1"=="" goto :done
    call %FIX_CMD% "%~1"
    @shift
    @goto :process_args
:done
@exit /b 0
