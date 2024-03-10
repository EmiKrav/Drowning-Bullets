extends Node3D

@onready var HBox = get_node("%CanvasLayer")

@onready var node = get_node("%CharacterBody3D")

var monstrai = preload("res://Scenes/monster.tscn")

func _ready():
	for child in get_children():#Iterate trough the children  
		print(child.get_name())


func _process(_delta):
	if get_child_count() == 0:
		node.process_mode = PROCESS_MODE_DISABLED
		
		node.set_visible(false)
		
		for child in node.get_children():
			child.set_visible(false)
		
		HBox.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		
		

func _on_button_pressed():
	var monstrai_instance = monstrai.instantiate()
	
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
	
