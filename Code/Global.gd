extends Node

var banga = 1

func _ready():
	pass

func KitaBanga():
	Global.banga += 1

func Reset():
	Global.banga = 1
