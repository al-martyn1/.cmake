@echo off
@rem powershell "((Get-Content -path \"%1\" -Raw) -replace 'namespace public {','namespace public_ {') | Set-Content -Path \"%1\""
@rem powershell "((Get-Content -path \"%1\" -Raw) -replace '::public::','::public_::')                 | Set-Content -Path \"%1\""
powershell -File "%~dp0\fix_cpp_keywords.ps1" "%~1"
