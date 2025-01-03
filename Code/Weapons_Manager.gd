extends Node3D

signal WeaponChanged
signal UpdateAmmo
signal Mousesensiv
signal UpdateWeaponStack
signal naikintkulka
signal kraujuoti
signal taskyti
signal nocros


@onready var AnimPlayer = get_node("%AnimationPlayer")
@onready var BulletPoint = get_node("%Bullet_point")
@onready var BulletRay = preload("res://Scenes/bullet_ray.tscn")
@onready var WaterSplash = preload("res://Scenes/watereffect.tscn")
@onready var WaterEffect = preload("res://Scenes/sprite_3d.tscn")

@onready var MainCamera = get_node("%MainCamera")

@onready var Bullet = preload("res://Scenes/bullet.tscn")

@onready var kulka = load("res://Scenes/kulka.tscn")

var current_weapon = null

var Weapon_Stack = []

var Weapon_Indicator = 0

var Next_Weapon: String

var Weapon_List = {}

var FOV = -40
var prizoominta = false
var check = false
var mining = false;
var getkristals = false;

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
	if !mining && event.is_action_pressed("weapon_Up"):
		if Weapon_Indicator == 0:
			Weapon_Indicator = 1
		else:
			Weapon_Indicator = 0#min(Weapon_Indicator+1, Weapon_Stack.size()-1)
		exit(Weapon_Stack[Weapon_Indicator])

	if !mining && event.is_action_pressed("weapon_Down"):
		if Weapon_Indicator == 1:
			Weapon_Indicator = 0
		else:
			Weapon_Indicator = 1#max(Weapon_Indicator-1,0)
		exit(Weapon_Stack[Weapon_Indicator])
	if mining && event.is_action_pressed("weapon_Up"):
		if prizoominta == true:
				check = true
				zoom(FOV)
		AnimPlayer.play("pickaxeback")
		

	if mining && event.is_action_pressed("weapon_Down"):
		if prizoominta == true:
				check = true
				zoom(FOV)
		AnimPlayer.play("pickaxeback")
		
	if event.is_action_pressed("Shoot"):
		if !mining:
			shoot()
		else:
			minestart()
		
	if event.is_action_pressed("Reload"):
		reload()
	if event.is_action_pressed("zoom"):
		zoom(FOV)
		
	if event.is_action_pressed("mine"):
		mine()
		
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
	if !mining && _next_weapon != current_weapon.Weapon_Name:
		if AnimPlayer.get_current_animation() != current_weapon.Deactivate_Anim:
			if prizoominta == true:
				check = true
				zoom(FOV)
			AnimPlayer.play(current_weapon.Deactivate_Anim)
			Next_Weapon = _next_weapon
			
	
	
func Change(weapon_name: String):
	current_weapon = Weapon_List[weapon_name]
	Next_Weapon = ""
	enter()

func _on_animation_player_animation_finished(anim_name):
	
	if anim_name == current_weapon.Reload_Anim:
		if check == true:
			zoom(FOV)
			check = false
			
	if anim_name == current_weapon.Activate_Anim:
		if check == true:
			zoom(FOV)
			check = false
	if anim_name == current_weapon.Deactivate_Anim && !mining:
		Change(Next_Weapon)
		
	if (anim_name == current_weapon.Shoot_Anim || anim_name == current_weapon.Zoom_AnimSauti) && current_weapon.Auto_Fire == true:
		if Input.is_action_pressed("Shoot"):
			shoot()
		else :
			Music.SoundStop()
	if (anim_name == "pickaxe"):
		if check == true:
			zoom(FOV)
			check = false
	if (anim_name == "pickaxeback"):
		mining = false;
		enter()
		emit_signal("nocros", false)
	if (anim_name == "pickaxemine"):
		getkristals = false;
		if Input.is_action_pressed("Shoot"):
			minestart()
		

func shoot():
	if current_weapon.Current_Ammo != 0:
		if !AnimPlayer.is_playing():
			if zomintas == false:
				AnimPlayer.play(current_weapon.Shoot_Anim)
			else:
				AnimPlayer.play(current_weapon.Zoom_AnimSauti)
			var instance = kulka.instantiate()
			instance.position = BulletPoint.global_position
			instance.setvelocity(BulletPoint.global_position, GetCameraCollision())
			get_tree().get_root().get_child(0).add_child(instance)
			if current_weapon.Auto_Fire == false:
				Music.playsoundkulka(0)
			else:
				Music.playsoundkulkacont(0)
			current_weapon.Current_Ammo -= 1;
			emit_signal("UpdateAmmo", [current_weapon.Current_Ammo, current_weapon.Reserve_Ammo])
			var CameraCollision = GetCameraCollision()
			match current_weapon.Type:
				NULL:
					print("Weapon Type not chosen")
				HITSCAN:
					HitScanCollision(CameraCollision)
	else:
		Music.SoundStop()
		reload()

func zoom(zoomas):
	if !AnimPlayer.is_playing():
		if (!prizoominta):
			MainCamera.fov += zoomas
			prizoominta = true
			emit_signal("Mousesensiv", prizoominta)
			if (!mining):
				AnimPlayer.play(current_weapon.Zoom_Anim)
			zomintas = true
		else:
			MainCamera.fov -= zoomas
			prizoominta = false		
			emit_signal("Mousesensiv", prizoominta)
			if (!mining):
				AnimPlayer.play(current_weapon.Activate_Anim)
			zomintas = false
	
	
func reload():
	if current_weapon.Current_Ammo == current_weapon.Magazine:
		return
	elif !AnimPlayer.is_playing():
		Music.playsound(8)
		if Global.Ammo > 0:
			current_weapon.Reserve_Ammo += Global.Ammo
			Global.AmmoSunaudota(Global.Ammo)
		if current_weapon.Reserve_Ammo != 0:
			if prizoominta == true:
				zoom(FOV)
				check = true
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
	
	#print(RayEnd)
	if Global.underwater:
		RayEnd -= Vector3(0,100,0)
		#print(RayEnd)
	
	
	var NewIntersection = PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd,0b00000000_00000000_00000000_01001011)
	
	
	
	var Intersection = get_world_3d().direct_space_state.intersect_ray(NewIntersection)
	
	#print(Intersection.collider,Intersection.rid)
	
	if not Intersection.is_empty():
		var ColPoint = Intersection.position
		return ColPoint
	else:
		return RayEnd
	

func HitScanCollision(CollisionPoint):
	var BulletDirection = (CollisionPoint - BulletPoint.get_global_transform().origin).normalized()
	var NewIntersection = PhysicsRayQueryParameters3D.create(BulletPoint.get_global_transform().origin,
															 CollisionPoint + BulletDirection*2,0b00000000_00000000_00000000_01111011)
															
	var BulletCollision = get_world_3d().direct_space_state.intersect_ray(NewIntersection)
	
	
	if BulletCollision:
		var world = get_tree().get_root().get_child(0)
		var bulray = BulletRay.instantiate()
		#bulray.draw(BulletPoint.global_position, CollisionPoint)
		world.add_child(bulray)
		if (BulletCollision.collider.get_collision_layer_value(6) || BulletCollision.collider.get_collision_layer_value(5)):
			var watereffect = WaterEffect.instantiate()
			#bulray.look_at(watereffect.global_transform.origin + BulletCollision.normal, Vector3.UP)
			world.add_child(watereffect)
			
			#var splash = WaterSplash.instantiate()
			#world.add_child(splash)
			#splash.global_position = BulletCollision.position
			watereffect.global_position = BulletCollision.position
			#if BulletCollision.normal == Vector3.DOWN:
				#watereffect.rotation_degrees.x = 90
			#elif BulletCollision.normal != Vector3.UP:
				#watereffect.look_at(watereffect.global_transform.origin + BulletCollision.normal, Vector3.UP)
			#if (BulletCollision.normal != Vector3.UP and BulletCollision.normal != Vector3.DOWN):
				#watereffect.rotate_object_local(Vector3(1,0,0),90)
			emit_signal("taskyti")
		else:		
			var HitIndicator = Bullet.instantiate()
			#bulray.look_at(HitIndicator.global_transform.origin + BulletCollision.normal, Vector3.UP)
			world.add_child(HitIndicator)
			HitIndicator.global_position = BulletCollision.position
			if BulletCollision.normal == Vector3.DOWN:
				HitIndicator.rotation_degrees.x = 90
			elif BulletCollision.normal != Vector3.UP:
				HitIndicator.look_at(HitIndicator.global_transform.origin + BulletCollision.normal, Vector3.UP)
			if (BulletCollision.normal != Vector3.UP and BulletCollision.normal != Vector3.DOWN):
				HitIndicator.rotate_object_local(Vector3(1,0,0),90)

		bulray.global_position = BulletCollision.position
		if (BulletCollision.normal != Vector3.UP and BulletCollision.normal != Vector3.DOWN):
			bulray.rotate_object_local(Vector3(1,0,0),90)
		emit_signal("naikintkulka")
		
		
		HitScanDamage(BulletCollision.collider, BulletDirection, BulletCollision.position)
		
func  HitScanDamage(Collider, Direction, Position):
	if Collider.is_in_group("Target") and Collider.has_method("HitS"):
		Collider.HitS(current_weapon.Damage, Direction, Position)
		
		
		emit_signal("kraujuoti")
	


func _on_update_weapon_stack():
	current_weapon.Current_Ammo = current_weapon.Magazine
	current_weapon.Reserve_Ammo = current_weapon.Max_Ammo
	
func mine():
	if !AnimPlayer.is_playing():
		if !mining:
			emit_signal("nocros", true)
			if prizoominta == true:
				zoom(FOV)
				check = true
			AnimPlayer.play(current_weapon.Deactivate_Anim)
			AnimPlayer.queue("pickaxe")
			mining = true;
			
func minestart():
	AnimPlayer.play("pickaxemine")
	getkristals = true;
	
func CollectKristalus():
	return getkristals
