extends Node3D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused == true:
			#print_debug("spaudzia")
			get_tree().paused = false;
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
			queue_free()

func _on_leave_pressed():
	#Global.Mirus()
	Global.Reset()
	get_tree().paused = false;
	if Music.muted:
		Music.MusicStop()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

