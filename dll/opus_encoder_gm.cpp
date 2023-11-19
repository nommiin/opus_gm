#include "opus_gm.h"
#define MAX_PACKET 1500

GMFUNC(__opus_encode) {
	OpusEncoder* state = (OpusEncoder*)YYGetPtr(arg, 0);
	int input_buffer = YYGetReal(arg, 1);
	int frame_size = YYGetReal(arg, 2);
	int output_buffer = YYGetReal(arg, 3);

	Result.kind = VALUE_REAL;
	Result.val = opus_encode(state, (opus_int16*)BufferGet(BufferGetFromGML(input_buffer)), frame_size, BufferGet(BufferGetFromGML(output_buffer)), MAX_PACKET);
}

GMFUNC(__opus_encoder_create) {
	int sample_rate = YYGetReal(arg, 0);
	int channels = YYGetReal(arg, 1);
	int application = YYGetReal(arg, 2);

	int error = 0;
	void* encoder = opus_encoder_create(sample_rate, channels, application, &error);
	if (error == OPUS_OK) {
		Result.kind = VALUE_PTR;
		Result.ptr = encoder;
	} else {
		Result.kind = VALUE_REAL;
		Result.val = error;
	}
}

GMFUNC(__opus_encoder_destroy) {
	OpusEncoder* state = (OpusEncoder*)YYGetPtr(arg, 0);
	opus_encoder_destroy(state);
}

GMFUNC(__opus_encoder_get_size) {
	int channels = YYGetReal(arg, 0);

	Result.kind = VALUE_REAL;
	Result.val = opus_encoder_get_size(channels);
}