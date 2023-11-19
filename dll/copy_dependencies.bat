@echo off
set program=GameMakerStudio2-Beta
set runtime=runtime-2023.1100.0.453
set base=%PROGRAMDATA%\%program%\Cache\runtimes\%runtime%\yyc\include

copy "%base%\extension\YYRunnerInterface.h" "Extension_Interface.h"
copy "%base%\YYStd.h"
copy "%base%\Ref.h"

echo #include "Ref.h" >> YYRValue.h
type %base%\YYRValue.h >> YYRValue.h
echo Copied and modified YYRValue.h