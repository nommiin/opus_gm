if (encoder != -1) {
	var buffer = async_load[? "buffer_id"], len = async_load[? "data_len"];//, encode = opus_encode(encoder, buffer, OPUS_FRAMESIZE_ARG, output);
	var copy = buffer_create(len, buffer_fixed, 1);
	buffer_copy(buffer, 0, len, copy, 0);
	audio_queue_sound(queue_raw, copy, 0, len);
	
	var encode = opus_encode(encoder, copy, 960, output);
	if (encode > 0) {
		var samples = opus_decode(self.decoder, output, encode, decode, 960, true);
		if (samples > 0) {
			var copy2 = buffer_create_alloc(len, buffer_fixed, 1);
			show_debug_message(instanceof(self));
			var arg2 = self.output;
			var decoded = opus_decode(self.decoder, arg2, len, copy2, 960, true);
			show_debug_message(buffer_crc32(copy2, 0, len));
			try {
				audio_queue_sound(queue_compressed, copy2, 0, len);
			} catch (e) {}
		} else {
			show_debug_message("Failed to decode frame: {0}", samples);	
		}
		show_debug_message("Encoded={0}, Samples={1}", encode, samples);
		//var decompress = buffer_create_alloc(encode * 2, buffer_fixed, 1);
		//var decode = opus_decode(decoder, output, encode, 0, 1, true);
		//show_debug_message("decode=" + string(decode));
		//audio_queue_sound(queue_compressed, decompress, 0, buffer_get_size(decompress));
		//show_debug_message("Decompress={0}", decompress);
	} else {
		show_debug_message("Failed to encode frame: {0}", opus_strerror(encode));
	}
	
	//
}