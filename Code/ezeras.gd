extends Node3D

@onready var HitReact = $Control/ColorRect

		
func _ready():
	if !Global.keisti:
		get_tree().paused = true;
		


func _on_player_player_hit(_Gyvybes):
	HitReact.visible = true
	await get_tree().create_timer(0.2).timeout
	HitReact.visible = false


	
