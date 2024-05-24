extends Node3D

@onready var HitReact = $Control/ColorRect

func _ready():
	if Music.current() != 2:
		Music.play2()


func _on_player_player_hit(_Gyvybes):
	HitReact.visible = true
	await get_tree().create_timer(0.2).timeout
	HitReact.visible = false

