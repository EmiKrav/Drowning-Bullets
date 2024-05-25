extends Button

func _on_esc_pressed():
	Global.Reset()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


func _on_Mir_pressed():
	Global.Mirus()
	Global.Reset()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
