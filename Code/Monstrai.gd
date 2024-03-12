extends Node3D

@onready var HBox = get_node("%CanvasLayer")

@onready var node = get_node("%CharacterBody3D")

var monstrai = preload("res://Scenes/monster.tscn")

var spausta = false;

func _process(_delta):
	if get_child_count() == 0 &&  !spausta:
		spausta = true
		Menu()
		
		
func Menu():
	await get_tree().create_timer(3.0).timeout
	node.process_mode = PROCESS_MODE_DISABLED
		
	node.set_visible(false)
		
	for child in node.get_children():
		child.set_visible(false)
		
	HBox.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		
		

func _on_button_pressed():
	var monstrai_instance = monstrai.instantiate()
	monstrai_instance.position = Vector3(-68.51, -15.642, 28.035 )
	
	#for child in monstrai_instance.get_children():#Iterate trough the children  
		#print(child.get_name())
		#add_child(child)
	
	add_child(monstrai_instance)
	node.set_visible(true)
	for child in node.get_children():
			child.set_visible(true)
			
	HBox.visible = false
	node.process_mode = PROCESS_MODE_INHERIT
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	spausta = false
	

