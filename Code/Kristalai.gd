extends Node3D

@onready var kris = preload("res://Scenes/Kristalas.tscn")
@onready var node = get_node("%Player")

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	

	for i in get_child_count():
		#var point = get_child(i).global_position
		var kristalas = kris.instantiate()
		#kristalas.position = point
		#get_tree().get_root().get_child(0).add_child(kristalas)
		#get_parent().get_child(2).get_child(i).add_child(kristalas)
		get_child(i).add_child(kristalas)
		kristalas.player = node	
		
func _on_monstrai_spawn():
	for i in get_child_count():
		if get_child(i).get_child_count() == 0:
		#var point = get_child(i).global_position
			var kristalas = kris.instantiate()
			#kristalas.position = point
			#get_tree().get_root().get_child(0).add_child(kristalas)
			#get_parent().get_child(2).get_child(i).add_child(kristalas)
			get_child(i).add_child(kristalas)
			kristalas.player = node	
