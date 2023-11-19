var str = $"opus_gm ({opus_get_version()}):\nencoder={encoder}, decoder={decoder}\n\n";
switch (state) {
	case 0: {
		if (array_length(recorders) > 0) {
			if (keyboard_check_pressed(vk_up)) {
				if (--index < 0) {
					index = array_length(recorders) - 1;	
				}
			} else if (keyboard_check_pressed(vk_down)) {
				if (++index >= array_length(recorders)) {
					index = 0;	
				}
			}
		
			for(var i = 0; i < array_length(recorders); i++) {
				var recorder = recorders[i];
				if (index == i) {
					str += "-> ";	
				}
			
				str += $"{i}: {recorder.name} @ {recorder.sample_rate}Hz\n";
			}
			
			if (keyboard_check_pressed(vk_space)) {
				setup_recorder(index);
				state = 1;
			}
			str += "\nPress [SPACE] to select a device to record";
		} else {
			if (keyboard_check_pressed(vk_space)) {
				game_end();	
			}
			
			str += "Could not find any recording devices\n\nPress [SPACE] to exit the program";	
		}
		break;	
	}
	
	case 1: {
		var recorder = recorders[index];
		var t = (time - time_recording) div 60;
		var m = t div 60;
		var s = t mod 60;
		str += $"Recording {channels} channels for {recorder.name} at {recorder.sample_rate}Hz\nDuration: {m}:{(s > 9 ? s : "0" + string(s))}\n";
		str += "\nPress [SPACE] to quit recording"
		
		if (keyboard_check_pressed(vk_space)) {
			stop_recorder(index);
			state = 2;	
		}
		break;	
	}
	
	case 2: {
		if (mouse_check_button_pressed(mb_left)) {
			if (!audio_is_playing(queue_raw)) {
				audio_play_sound(queue_raw, 0, false);	
			} else {
				audio_stop_sound(queue_raw);	
			}
		} else if (mouse_check_button_pressed(mb_right)) {
			if (!audio_is_playing(queue_compressed)) {
				audio_play_sound(queue_compressed, 0, false);	
			} else {
				audio_stop_sound(queue_compressed);	
			}
		}
		
		if (keyboard_check_pressed(vk_space)) {
			state = 0;	
		}
		
		str += "Press [LMB] to play raw audio (" + (audio_is_playing(queue_raw) ? "Playing" : "Not Playing") + ")\nPress [RMB] to play compressed audio (" + (audio_is_playing(queue_compressed) ? "Playing" : "Not Playing") + ")\n\nPress [SPACE] to return";
		break;	
	}
}

draw_text(4, 18, str);
time++;