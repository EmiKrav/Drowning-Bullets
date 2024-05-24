extends Node3D

@onready var ezeras = preload("res://Scenes/ezeras.tscn")
@onready var arsenalas = preload("res://Scenes/Arsenalas.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	get_tree().paused = false;
	
	if Music.current() != 1:
		Music.play1()
		Music.filterback()

func _on_button_pressed():
	get_tree().change_scene_to_packed(ezeras)

func _on_quit_pressed():
	get_tree().quit()


func _on_arsenal_pressed():
	get_tree().change_scene_to_packed(arsenalas)
