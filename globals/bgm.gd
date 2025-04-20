extends AudioStreamPlayer

func play_song(song: AudioStream):
	if !(self.get_stream() == song):
		self.stop()
		print(song)
		self.set_stream(song)
		self.play(0)

func _on_finished() -> void:
	self.play(0)
