@echo off
@rem powershell "((Get-Content -path \"%1\" -Raw) -replace 'namespace public {','namespace public_ {') | Set-Content -Path \"%1\""
@rem powershell "((Get-Content -path \"%1\" -Raw) -replace '::public::','::public_::')                 | Set-Content -Path \"%1\""

@if "%UMBA_SUBST_MACROS_EXECUTABLE%"=="" goto USE_POWERSHELL
@goto USE_UMBA_SUBST_MACROS
:USE_POWERSHELL
@powershell -File "%~dp0\fix_cpp_keywords.ps1" "%~1"
@goto END
:USE_UMBA_SUBST_MACROS
@"%UMBA_SUBST_MACROS_EXECUTABLE%" --overwrite --raw=1 "-S:namespace public {=namespace public_ {" "-S:::public::=::public_::" "%~1" "%~1"
:END