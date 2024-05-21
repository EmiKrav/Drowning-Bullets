extends CharacterBody3D

@onready var MainCamera = get_node("%MainCamera")
var pauze = preload("res://Scenes/Pause.tscn")

var mirtis = preload("res://Scenes/Mirtis.tscn")

var mat = preload("res://textures/terrain.tres")
var caust = preload("res://Resource/underwater.material")

var SPEED = 6
const JUMP_VELOCITY = 4.5
const  HitStag = 5.0

var CameraRotation = Vector2(0,0)
var MouseSensitivity = 0.004

var MaxHealth = 100
var Health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var paused

var underwater = false
var showtime = true

signal PlayerHit
signal Banga
signal LifeReplene
signal AmmoRasta
signal DaiktasRastas
signal zoom

func _ready():
	paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused == false && !paused:	
			var w = pauze.instantiate()
			get_parent().add_child(w)
			paused = true
			get_tree().paused = true;
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		else:
			get_tree().paused = false;
			paused = false
		
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative *MouseSensitivity;
		CameraLook(MouseEvent);
		
func CameraLook(Movement: Vector2):
	CameraRotation += Movement;
	CameraRotation.y = clamp(CameraRotation.y, -1.5,1.2);
	
	
	transform.basis = Basis();
	MainCamera.transform.basis = Basis();
	
	rotate_object_local(Vector3(0,1,0), -CameraRotation.x);
	MainCamera.rotate_object_local(Vector3(1,0,0), -CameraRotation.y);
	
	
	
#var chase = true;
func _physics_process(delta):
	# Add the gravity.
	if (underwater && showtime):
		$CanvasLayer/VBoxContainer4/HBoxContainer/Label.text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	
	if (underwater && $RayCast3D.is_colliding()):
		$"../DirectionalLight3D".light_energy = 3.252
		$"../WorldEnvironment".get_environment().volumetric_fog_enabled = false
		mat.emission_enabled = true
		mat.albedo_color = "#6b3903"
		mat.next_pass = null
		$"../Map/NavigationRegion3D/Water".mesh.flip_faces = false
		$Timer.stop()
		$CanvasLayer/VBoxContainer4/HBoxContainer/Label.text = ""
		underwater = false
		$".".set_collision_mask_value(5,true)
		gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
		SPEED = 6 
		
	
	if not is_on_floor() and !underwater:
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept") and underwater:
		velocity.y = 2
	
		
		
	if Input.is_action_just_pressed("Drink"):
		var trukstaHp = MaxHealth - Health
		if Global.life > 0 && Health < MaxHealth:
			if (Global.life - trukstaHp >= 0):
				Health += trukstaHp
				Global.LifeSunaudota(trukstaHp)
			else:
				Health += Global.life
				Global.LifeSunaudota(Global.life)
			emit_signal("LifeReplene", Health)
	
	if Input.is_action_just_pressed("Surge"):
		if (underwater == false  && $RayCast3D.is_colliding()):
			mat.next_pass = caust
			$".".set_collision_mask_value(5,false)
			$"../Map/NavigationRegion3D/Water".mesh.flip_faces = true
			gravity = 0
			SPEED /=2 
			velocity.y -= 2
			await get_tree().create_timer(0.3).timeout
			$"../WorldEnvironment".get_environment().volumetric_fog_enabled = true
			$"../DirectionalLight3D".light_energy = 1
			#$"../../WorldEnvironment".get_environment().background_energy_multiplier= 0.25
			mat.emission_enabled = false
			mat.albedo_color = "#4b2601"
			mat.next_pass = caust
			await get_tree().create_timer(0.2).timeout
			underwater = true
			$Timer.wait_time = 20
			$Timer.start()
			showtime = true
		else:
			velocity.y = -2
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#if collision.get_collider().has_method("Hurt"):
			#if chase == true:
				#chase = false
				#take_damage()
				#return			
				
func Hit(dir):
	Health -= 1
	emit_signal("PlayerHit", Health)
	velocity += dir * HitStag
	if (Health <= 0 ):
		get_tree().paused = true;
		var w = mirtis.instantiate()
		get_parent().add_child(w)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
			
func Drown():
	if (underwater):
		showtime = false
		Health -= 1
		emit_signal("PlayerHit", Health)
	if (Health <= 0 ):
		get_tree().paused = true;
		var w = mirtis.instantiate()
		get_parent().add_child(w)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		
#func take_damage():
	#Health -=1;
	##print("Health", str(Health)) 
	#await get_tree().create_timer(1.0).timeout
	#chase = true;
	#return;
	


func _on_weapons_manager_mousesensiv(prizzomintas):
	if prizzomintas:
		MouseSensitivity -= 0.002
		emit_signal("zoom", true)
	else:
		MouseSensitivity += 0.002
		emit_signal("zoom", false)


func _on_monstrai_banga():
	emit_signal("Banga")

func lifeUpdate():
	emit_signal("LifeReplene", Health)
	
func AmmoUpdate():
	emit_signal("AmmoRasta")
	
func UpgradeUpdate():
	emit_signal("DaiktasRastas")



func _on_timer_timeout():
	if (underwater && $Timer.time_left == 0):
		Drown()
		$Timer.wait_time = 1
		$Timer.start()
