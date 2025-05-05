extends AudioStreamPlayer

# Plays song inserted as parameter
func play_song(song: AudioStream):
	if !(self.get_stream() == song):
		self.stop()
		print(song)
		self.set_stream(song)
		self.play(0)

func play_sound(sound: AudioStream):
	print("Sound!")
