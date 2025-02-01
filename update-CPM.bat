@rem CPM.cmake - Setup-free CMake dependency management - https://github.com/cpm-cmake/CPM.cmake?tab=readme-ov-file
@rem Direct link to current latest release - https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.40.5/CPM.cmake
@set CURL_PROXY_OPT=
@set WGET_PROXY_OPT=
@if "%HTTPS_PROXY%"=="" @goto NO_PROXY
@set CURL_PROXY_OPT=--proxy "HTTPS_PROXY"
@rem Need to configure proxy for WGET
@rem set WGET_PROXY_OPT=

:NO_PROXY
@if "%1"=="WGET" @goto USE_WGET

@curl --help      > curl-help.txt
@curl --help all >> curl-help.txt
@curl -v --insecure --location --remote-name %CURL_PROXY_OPT% "https://github.com/cpm-cmake/CPM.cmake/releases/latest/download/CPM.cmake" >update-CPM.log 2>&1
@goto END

:USE_WGET
@wget -O CPM.cmake https://github.com/cpm-cmake/CPM.cmake/releases/latest/download/CPM.cmake >update-CPM.log 2>&1

:END