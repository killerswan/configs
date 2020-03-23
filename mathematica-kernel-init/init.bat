setlocal enableextensions

mkdir                       "%appdata%\Mathematica\Licensing"
copy "%~dp0\mathpass"       "%appdata%\Mathematica\Licensing\mathpass"

mkdir                       "%appdata%\Mathematica\Kernel"
copy "%~dp0\init.m"         "%appdata%\Mathematica\Kernel\init.m"

mkdir                       "%appdata%\Mathematica\Kernel\FrontEnd"
copy "%~dp0\FrontEndInit.m" "%appdata%\Mathematica\Kernel\FrontEnd\init.m"
