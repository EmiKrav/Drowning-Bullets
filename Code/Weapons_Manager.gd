extends Node3D

signal WeaponChanged
signal UpdateAmmo
signal Mousesensiv
signal UpdateWeaponStack

@onready var AnimPlayer = get_node("%AnimationPlayer")
@onready var BulletPoint = get_node("%Bullet_point")
@onready var BulletRay = preload("res://Scenes/bullet_ray.tscn")

@onready var MainCamera = get_node("%MainCamera")

@onready var Bullet = preload("res://Scenes/bullet.tscn")

var current_weapon = null

var Weapon_Stack = []

var Weapon_Indicator = 0

var Next_Weapon: String

var Weapon_List = {}

var FOV = -40
var prizoominta = false

@export var _weapon_resources: Array[Weapons_Resource]

@export var Start_Weapons: Array[String]

enum {NULL,HITSCAN}

signal AmmoRasta

var zomintas = false

func _ready():
	for weapon in _weapon_resources:
		Weapon_List[weapon.Weapon_Name] = weapon
		
	for i in Start_Weapons:
		Weapon_Stack.push_back(i)
		
	for i in Weapon_Stack:
		current_weapon = Weapon_List[i]
		current_weapon.Current_Ammo = current_weapon.Magazine
		current_weapon.Reserve_Ammo = current_weapon.Max_Ammo - current_weapon.Magazine
	
	Initialize(Start_Weapons)
	
func _input(event):
	if event.is_action_pressed("weapon_Up"):
		Weapon_Indicator = 0#min(Weapon_Indicator+1, Weapon_Stack.size()-1)
		exit(Weapon_Stack[Weapon_Indicator])

	if event.is_action_pressed("weapon_Down"):
		Weapon_Indicator = 1#max(Weapon_Indicator-1,0)
		exit(Weapon_Stack[Weapon_Indicator])
		
	if event.is_action_pressed("Shoot"):
		shoot()
		
	if event.is_action_pressed("Reload"):
		reload()
	if event.is_action_pressed("zoom"):
		zoom(FOV)
		
func Initialize(_start_weapons: Array):
	for weapon in _weapon_resources:
		Weapon_List[weapon.Weapon_Name] = weapon
		
	for i in _start_weapons:
		Weapon_Stack.push_back(i)

	current_weapon = Weapon_List[Weapon_Stack[0]]
	emit_signal("UpdateWeaponStack")
	enter()
	
		
func enter():
	AnimPlayer.queue(current_weapon.Activate_Anim)
	emit_signal("WeaponChanged", current_weapon.Weapon_Name)
	emit_signal("UpdateAmmo", [current_weapon.Current_Ammo, current_weapon.Reserve_Ammo])
	
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
		
	if anim_name == current_weapon.Shoot_Anim && current_weapon.Auto_Fire == true:
		if Input.is_action_pressed("Shoot"):
			shoot()
		

func shoot():
	if current_weapon.Current_Ammo != 0:
		if !AnimPlayer.is_playing():
			if zomintas == false:
				AnimPlayer.play(current_weapon.Shoot_Anim)
			else:
				AnimPlayer.play(current_weapon.Zoom_AnimSauti)
			current_weapon.Current_Ammo -= 1;
			emit_signal("UpdateAmmo", [current_weapon.Current_Ammo, current_weapon.Reserve_Ammo])
			var CameraCollision = GetCameraCollision()
			match current_weapon.Type:
				NULL:
					print("Weapon Type not chosen")
				HITSCAN:
					HitScanCollision(CameraCollision)
	else:
		reload()

func zoom(zoomas):
	if (!prizoominta):
		MainCamera.fov += zoomas
		prizoominta = true
		emit_signal("Mousesensiv", prizoominta)
		AnimPlayer.play(current_weapon.Zoom_Anim)
		zomintas = true
	else:
		MainCamera.fov -= zoomas
		prizoominta = false		
		emit_signal("Mousesensiv", prizoominta)
		AnimPlayer.play(current_weapon.Activate_Anim)
		zomintas = false
	
	
func reload():
	if current_weapon.Current_Ammo == current_weapon.Magazine:
		return
	elif !AnimPlayer.is_playing():
		if Global.Ammo > 0:
			current_weapon.Reserve_Ammo += Global.Ammo
			Global.AmmoSunaudota(Global.Ammo)
		if current_weapon.Reserve_Ammo != 0:
			AnimPlayer.play(current_weapon.Reload_Anim)
			var Reload_Ammount = min(current_weapon.Magazine-current_weapon.Current_Ammo,
									 current_weapon.Magazine, current_weapon.Reserve_Ammo)
									
			current_weapon.Current_Ammo = current_weapon.Current_Ammo + Reload_Ammount
			current_weapon.Reserve_Ammo = current_weapon.Reserve_Ammo - Reload_Ammount

			
			emit_signal("UpdateAmmo", [current_weapon.Current_Ammo, current_weapon.Reserve_Ammo])
			emit_signal("AmmoRasta")
func GetCameraCollision()->Vector3:
	var camera = get_viewport().get_camera_3d()
	var viewport = get_viewport().get_size()
	
	var RayOrigin = camera.project_ray_origin(viewport/2)
	var RayEnd = RayOrigin + camera.project_ray_normal(viewport/2)*current_weapon.WeaponRange
	
	var NewIntersection = PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd)
	
	var Intersection = get_world_3d().direct_space_state.intersect_ray(NewIntersection)
	
	if not Intersection.is_empty():
		var ColPoint = Intersection.position
		return ColPoint
	else:
		return RayEnd
	
func HitScanCollision(CollisionPoint):
	var BulletDirection = (CollisionPoint - BulletPoint.get_global_transform().origin).normalized()
	var NewIntersection = PhysicsRayQueryParameters3D.create(BulletPoint.get_global_transform().origin,
															 CollisionPoint + BulletDirection*2)
															
	var BulletCollision = get_world_3d().direct_space_state.intersect_ray(NewIntersection)
	
	
	if BulletCollision:
		var HitIndicator = Bullet.instantiate()
		var world = get_tree().get_root().get_child(0)
		world.add_child(HitIndicator)
		HitIndicator.global_translate(BulletCollision.position)
		
		var bulray = BulletRay.instantiate()
		bulray.draw(BulletPoint.global_position, CollisionPoint)
		world.add_child(bulray)
		
		
		HitScanDamage(BulletCollision.collider, BulletDirection, BulletCollision.position)
		
func  HitScanDamage(Collider, Direction, Position):	
	if Collider.is_in_group("Target") and Collider.has_method("HitS"):
		Collider.HitS(current_weapon.Damage, Direction, Position)
	


func _on_update_weapon_stack():
	current_weapon.Current_Ammo = current_weapon.Magazine
	current_weapon.Reserve_Ammo = current_weapon.Max_Ammo
