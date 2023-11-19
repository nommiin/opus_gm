#pragma once
#include "Extension_Interface.h"
#include "YYRValue.h"
#include <opus.h>

extern RValue g_Copy;

// Modifiers for brief (see Wrapper.js)
#define GMDEFAULT(...) /**/
#define GMPASSTHROUGH(...) /**/
#define GMHIDDEN(...) /**/
#define GMPREPEND(...) /**/
#define GMAPPEND(...) /**/
#define GMOVERRIDE(...) /**/
#define GMRETURN(...) /**/
#define GMRETURNS(...) /**/
#define GMHINT(...) /**/
#ifdef _WIN32
#define GMEXPORT __declspec(dllexport)
#elif __linux__
#define GMEXPORT __attribute__((visibility("default")))
#endif

#define GMFUNC(name) GMEXPORT void name(RValue& Result, CInstance* selfinst, CInstance* otherinst, int argc, RValue* arg)