extends Node3D

@onready var HBox = get_node("%CanvasLayer")

@onready var node = get_node("%Player")

@onready var Nav = $"../NavigationRegion3D"

var count = 0
var prisukiekis = 3

var monstrai = preload("res://Scenes/monster.tscn")

var spausta = false;

signal banga

func _ready():
	
	
	process_mode = Node.PROCESS_MODE_PAUSABLE
	randomize()
	
	for i in prisukiekis:
		var spawnpoint = GetRandomPlace().global_position
		var monstrai_instance = monstrai.instantiate()
		monstrai_instance.position = spawnpoint
		add_child(monstrai_instance)
		monstrai_instance.Player = node
		await get_tree().create_timer(0.1).timeout
	
	#for child in monstrai_instance.get_children():#Iterate trough the children  
		#print(child.get_name())
		#add_child(child)
	
	
func _physics_process(_delta):
	
	count = 0
	for target in get_tree().get_nodes_in_group("Target"):
		count+=1;
		break;
	if count == 0 &&  !spausta:
		spausta = true
		Menu()


func GetRandomPlace():
	var random = randi() % get_child_count()
	return get_child(random)


		
func Menu():
	await get_tree().create_timer(3.0).timeout
	if get_tree().paused == false:
		node.process_mode = PROCESS_MODE_DISABLED
		node.set_visible(false)
		for child in node.get_children():
			child.set_visible(false)
		HBox.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	else:
		spausta = false
		

func _on_button_pressed():
	
	Global.KitaBanga()
	emit_signal("banga")
	
	
	node.process_mode = PROCESS_MODE_INHERIT
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
	prisukiekis += round(float(prisukiekis)/2) 
	
	node.set_visible(true)
	for child in node.get_children():
			child.set_visible(true)
			
	HBox.visible = false

	spausta = false
	
	
	for i in prisukiekis:
		var spawnpoint = GetRandomPlace().global_position
		var monstrai_instance = monstrai.instantiate()
		monstrai_instance.position = spawnpoint
		add_child(monstrai_instance)
		monstrai_instance.Player = node
		await get_tree().create_timer(1).timeout
		




	
