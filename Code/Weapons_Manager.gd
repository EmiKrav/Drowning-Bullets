extends Node3D

@onready var AnimPlayer = get_node("%AnimationPlayer")

var current_weapon = null

var Weapon_Stack = []

var Weapon_Indicator = 0

var Next_Weapon: String

var Weapon_List = {}

@export var _weapon_resources: Array[Weapons_Resource]

@export var Start_Weapons: Array[String]

func _ready():
	Initialize(Start_Weapons)
	
func _input(event):
	if event.is_action_pressed("weapon_Up"):
		Weapon_Indicator = 0#min(Weapon_Indicator+1, Weapon_Stack.size()-1)
		exit(Weapon_Stack[Weapon_Indicator])

	if event.is_action_pressed("weapon_Down"):
		Weapon_Indicator = 1#max(Weapon_Indicator-1,0)
		exit(Weapon_Stack[Weapon_Indicator])
		
func Initialize(_start_weapons: Array):
	for weapon in _weapon_resources:
		Weapon_List[weapon.Weapon_Name] = weapon
		
	for i in _start_weapons:
		Weapon_Stack.push_back(i)

	current_weapon = Weapon_List[Weapon_Stack[0]]
	enter()
	
		
func enter():
	AnimPlayer.queue(current_weapon.Activate_Anim)
	
func exit(_next_weapon: String):
	if _next_weapon != current_weapon.Weapon_Name:
		if AnimPlayer.get_current_animation() != current_weapon.Deactivate_Anim:
			AnimPlayer.play(current_weapon.Deactivate_Anim)
			Next_Weapon = _next_weapon
			
	
	
func Change(weapon_name: String):
	current_weapon = Weapon_List[weapon_name]
	Next_Weapon = ""
	enter()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == current_weapon.Deactivate_Anim:
		Change(Next_Weapon)
