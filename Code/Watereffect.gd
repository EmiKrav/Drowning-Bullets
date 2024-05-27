extends MeshInstance3D


var alpha = 1.0

@onready var emitter = get_tree().get_root().get_child(2)
@onready var wm = emitter.get_node("Player/MainCamera/Weapons_Manager")

func  _ready():
	#var dup_mat = material_override.duplicate()
	#material_override = dup_mat
	wm.taskyti.connect(paleisti)
	
func paleisti():
	$GPUParticles3D.emitting = true
	

func _process(delta):
	pass
	#alpha -= delta * 3.5
	#material_override.albedo_color.a = alpha


func _on_timer_timeout():
	queue_free()
