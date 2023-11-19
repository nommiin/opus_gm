#include "opus_gm.h"

RValue g_Copy;
YYRunnerInterface gs_runnerInterface;
YYRunnerInterface* g_pYYRunnerInterface;

GMEXPORT void YYExtensionInitialise(const struct YYRunnerInterface* _pFunctions, size_t _functions_size) {
	if (_functions_size < sizeof(YYRunnerInterface)) {
		memcpy(&gs_runnerInterface, _pFunctions, _functions_size);
	} else {
		memcpy(&gs_runnerInterface, _pFunctions, sizeof(YYRunnerInterface));
	}
	g_pYYRunnerInterface = &gs_runnerInterface;
	return;
}