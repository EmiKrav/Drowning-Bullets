extends MeshInstance3D

var alpha = 1.0

@onready var emitter = get_tree().get_root().get_child(1)
@onready var wm = emitter.get_node("Map/Player/MainCamera/Weapons_Manager")

func  _ready():
	var dup_mat = material_override.duplicate()
	material_override = dup_mat
	wm.kraujuoti.connect(paleisti)
	
func paleisti():
	$GPUParticles3D.emitting = true
	

func _process(delta):
	alpha -= delta * 3.5
	material_override.albedo_color.a = alpha
	


func draw(pos1, pos2):
	var drawmesh = ImmediateMesh.new()
	mesh = drawmesh
	drawmesh.surface_begin(Mesh.PRIMITIVE_LINES, material_override)
	
	
	#drawmesh.surface_add_vertex(pos1)
	#for i in range(0, 1, 0.005):
		#print(str(i))
		#var between = pos1.lerp(pos2, i);
		#drawmesh.surface_add_vertex(between)
		#
	var between = pos1.lerp(pos2, 0.775); 
	#var between = pos1.lerp(pos2, 0.675); 
	#var between1 = pos1.lerp(pos2, 0.7); 
	#var between2 = pos1.lerp(pos2, 0.725); 
	#var between3 = pos1.lerp(pos2, 0.75); 
	#var between4 = pos1.lerp(pos2, 0.775); 
	#var between5 = pos1.lerp(pos2, 0.8); 
	#var between6 = pos1.lerp(pos2, 0.825); 
	#var between7 = pos1.lerp(pos2, 0.85); 
	#var between8 = pos1.lerp(pos2, 0.875); 
	#var between9 = pos1.lerp(pos2, 0.9); 
	#var between10 = pos1.lerp(pos2, 0.925); 
	#var between11 = pos1.lerp(pos2, 0.95); 
	#
	#drawmesh.surface_add_vertex(between)
	#drawmesh.surface_add_vertex(between1)
	#drawmesh.surface_add_vertex(between2)
	#drawmesh.surface_add_vertex(between3)
	#drawmesh.surface_add_vertex(between4)
	#drawmesh.surface_add_vertex(between5)
	#drawmesh.surface_add_vertex(between6)
	#drawmesh.surface_add_vertex(between7)
	#drawmesh.surface_add_vertex(between8)
	#drawmesh.surface_add_vertex(between9)
	#drawmesh.surface_add_vertex(between10)
	#drawmesh.surface_add_vertex(between11)
	drawmesh.surface_add_vertex(between)
	drawmesh.surface_add_vertex(pos2)
	

	drawmesh.surface_end()

func _on_timer_timeout():
	queue_free()
