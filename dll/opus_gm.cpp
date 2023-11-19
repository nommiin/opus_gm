#include "opus_gm.h"

GMFUNC(__opus_get_version) {
	GMRETURNS(String);

	YYCreateString(&g_Copy, opus_get_version_string());
	COPY_RValue(&Result, &g_Copy);
}

GMFUNC(__opus_strerror) {
	GMRETURNS(String);
	int error = YYGetReal(arg, 0);

	YYCreateString(&g_Copy, opus_strerror(error));
	COPY_RValue(&Result, &g_Copy);
}