extends CanvasLayer




func _on_video_stream_player_finished():
	$"../CanvasLayer".visible = true
	Global.paleistas = true
