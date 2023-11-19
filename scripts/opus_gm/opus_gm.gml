/// @section Binds
/// @function opus_decode(state, input_buffer, input_length, output_buffer, frame_size, error_correction)
/// @argument {Pointer} state
/// @argument {Real} input_buffer
/// @argument {Real} input_length
/// @argument {Real} output_buffer
/// @argument {Real} frame_size
/// @argument {Bool} error_correction
/// @return {Real}
function opus_decode(state, input_buffer, input_length, output_buffer, frame_size, error_correction) {
	return __opus_decode(state, input_buffer, input_length, output_buffer, frame_size, error_correction);
}

/// @function opus_decoder_create(sample_rate, channels)
/// @argument {Real} sample_rate
/// @argument {Real} channels
/// @return {Unknown<unset>}
function opus_decoder_create(sample_rate, channels) {
	return __opus_decoder_create(sample_rate, channels);
}

/// @function opus_decoder_destroy(state)
/// @argument {Pointer} state
/// @return {Unknown<unset>}
function opus_decoder_destroy(state) {
	return __opus_decoder_destroy(state);
}

/// @function opus_encode(state, input_buffer, frame_size, output_buffer)
/// @argument {Pointer} state
/// @argument {Real} input_buffer
/// @argument {Real} frame_size
/// @argument {Real} output_buffer
/// @return {Real}
function opus_encode(state, input_buffer, frame_size, output_buffer) {
	return __opus_encode(state, input_buffer, frame_size, output_buffer);
}

/// @function opus_encoder_create(sample_rate, channels, application)
/// @argument {Real} sample_rate
/// @argument {Real} channels
/// @argument {Real} application
/// @return {Unknown<unset>}
function opus_encoder_create(sample_rate, channels, application) {
	return __opus_encoder_create(sample_rate, channels, application);
}

/// @function opus_encoder_destroy(state)
/// @argument {Pointer} state
/// @return {Unknown<unset>}
function opus_encoder_destroy(state) {
	return __opus_encoder_destroy(state);
}

/// @function opus_encoder_get_size(channels)
/// @argument {Real} channels
/// @return {Real}
function opus_encoder_get_size(channels) {
	return __opus_encoder_get_size(channels);
}

/// @function opus_get_version()
/// @return {String}
function opus_get_version() {
	return __opus_get_version();
}

/// @function opus_strerror(error)
/// @argument {Real} error
/// @return {String}
function opus_strerror(error) {
	return __opus_strerror(error);
}

/// @section Internal
if (!file_exists("opus.dll")) {
	return show_error("Could not load opus_gm, failed to find required opus.dll file", true);	
}

#macro OPUS_APPLICATION_VOIP			        2048
#macro OPUS_APPLICATION_AUDIO			        2049
#macro OPUS_APPLICATION_RESTRICTED_LOWDELAY		2051

#macro OPUS_FRAMESIZE_ARG						5000 /**< Select frame size from the argument (default) */
#macro OPUS_FRAMESIZE_2_5_MS					5001 /**< Use 2.5 ms frames */
#macro OPUS_FRAMESIZE_5_MS						5002 /**< Use 5 ms frames */
#macro OPUS_FRAMESIZE_10_MS						5003 /**< Use 10 ms frames */
#macro OPUS_FRAMESIZE_20_MS						5004 /**< Use 20 ms frames */
#macro OPUS_FRAMESIZE_40_MS						5005 /**< Use 40 ms frames */
#macro OPUS_FRAMESIZE_60_MS						5006 /**< Use 60 ms frames */
#macro OPUS_FRAMESIZE_80_MS						5007 /**< Use 80 ms frames */
#macro OPUS_FRAMESIZE_100_MS					5008 /**< Use 100 ms frames */
#macro OPUS_FRAMESIZE_120_MS					5009 /**< Use 120 ms frames */

/// @section Helpers
function buffer_create_alloc(size, type, alignment) {
	var b = buffer_create(size, type, alignment);
	buffer_fill(b, 0, buffer_u8, 0, size);
	buffer_seek(b, buffer_seek_start, 0);
	return b;
}