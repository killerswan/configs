setlocal enableextensions

rd /s /q ^
  "%localappdata%\Mathematica" ^
  "%localappdata%\Wolfram" ^
  "%localappdata%\Wolfram Research" ^
  ^
  "%programdata%\Mathematica" ^
  "%programdata%\Wolfram" ^
  "%programdata%\Wolfram Research" ^
  ^
  "%appdata%\Mathematica" ^
  "%appdata%\Wolfram" ^
  "%appdata%\Wolfram Research" ^
  ^
  "%userprofile%\eclAppData" ^
  "%appdata%\ECL"

