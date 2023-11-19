index = 0;
recorders = array_map(array_create(audio_get_recorder_count()), function(e, i) {
	var map = audio_get_recorder_info(i), info = json_parse(json_encode(map));
	audio_stop_recording(i);
	ds_map_destroy(map);
	return info;
});

state = 0;
time = 0;
time_recording = 0;
encoder = -1;
decoder = -1;
queue_raw = -1;
queue_compressed = -1;
channels = 1;
output = buffer_create_alloc(512, buffer_fixed, 1);
decode = buffer_create_alloc(512, buffer_fixed, 1);

function setup_recorder(ind) {
	var recorder = recorders[ind];
	encoder = opus_encoder_create(recorder.sample_rate, 2, OPUS_APPLICATION_VOIP);
	decoder = opus_decoder_create(recorder.sample_rate, 2);
	if (queue_raw != -1) audio_free_play_queue(queue_raw);	
	queue_raw = audio_create_play_queue(buffer_s16, recorder.sample_rate, audio_mono);
	if (queue_compressed != -1) audio_free_play_queue(queue_compressed);
	queue_compressed = audio_create_play_queue(buffer_s16, recorder.sample_rate, audio_mono);
	audio_start_recording(ind);
	time_recording = time;
}

function stop_recorder(ind) {
	opus_encoder_destroy(encoder);
	opus_decoder_destroy(decoder);
	audio_stop_recording(ind);
	encoder = -1;
	decoder = -1;
}

audio_debug(true);