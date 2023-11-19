#include "opus_gm.h"

GMFUNC(__opus_decode) {
	OpusDecoder* state = (OpusDecoder*)YYGetPtr(arg, 0);
	int input_buffer = YYGetReal(arg, 1);
	int input_length = YYGetReal(arg, 2);
	int output_buffer = YYGetReal(arg, 3);
	int frame_size = YYGetReal(arg, 4);
	bool error_correction = YYGetBool(arg, 5);

	Result.kind = VALUE_REAL;
	Result.val = opus_decode(state, BufferGet(BufferGetFromGML(input_buffer)), input_length, (opus_int16*)BufferGet(BufferGetFromGML(output_buffer)), frame_size, error_correction);
}

GMFUNC(__opus_decoder_create) {
	int sample_rate = YYGetReal(arg, 0);
	int channels = YYGetReal(arg, 1);

	int error = 0;
	void* decoder = opus_decoder_create(sample_rate, channels, &error);
	if (error == OPUS_OK) {
		Result.kind = VALUE_PTR;
		Result.ptr = decoder;
	} else {
		Result.kind = VALUE_REAL;
		Result.val = error;
	}
}

GMFUNC(__opus_decoder_destroy) {
	OpusDecoder* state = (OpusDecoder*)YYGetPtr(arg, 0);
	opus_decoder_destroy(state);
}