extends Node3D

@onready var ezeras = preload("res://Scenes/ezeras.tscn")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	get_tree().paused = false;

func _on_button_pressed():
	get_tree().change_scene_to_packed(ezeras)

func _on_quit_pressed():
	get_tree().quit()


func _on_arsenal_pressed():
	get_tree().change_scene_to_file("res://Scenes/Arsenalas.tscn")
