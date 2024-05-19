extends CharacterBody3D


var MaxHealth = 5
var Health = 5
const  AttackRange = 25
var stuck = false
var StateMachine

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#var Player = null
#@export var PlayerPath : NodePath
var alive = true
@onready var Player
const  Speed = 5.0
@onready var NavAgent = $NavigationAgent3D
@onready var AnimTree = $AnimationTree
@onready var bar = $Gyvyb
@onready var raycast = $RayCast3D
var fullhealth = Health
var AmmoBox = preload("res://Scenes/AmmoBox.tscn")
var Life = preload("res://Scenes/Gyvybes.tscn")
var Upgrade = preload("res://Scenes/Upgrade.tscn")
var Bullet = preload("res://Scenes/Monstroataka.tscn")


signal Dead

func _ready():
	StateMachine =AnimTree.get("parameters/playback")
	MaxHealth = bar.scale.x

	
func _physics_process(delta):
	velocity = Vector3.ZERO	
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()
		
	match StateMachine.get_current_node():
		"Fast_Flying":
			NavAgent.set_target_position(Player.global_transform.origin)
			var NextNavPoint = NavAgent.get_next_path_position()
			velocity = (NextNavPoint-global_transform.origin).normalized() * Speed
			move_and_slide()
					
			look_at(Vector3(Player.global_position.x  + velocity.x, Player.global_position.y + velocity.y,
					Player.global_position.z + velocity.z), Vector3.UP)
		"HitReact":
			look_at(Vector3(Player.global_position.x, Player.global_position.y,
					Player.global_position.z), Vector3.UP)
			
							
							
	AnimTree.set("parameters/conditions/Shoot", TargetInRange())
	AnimTree.set("parameters/conditions/Fly", !TargetInRange())
	AnimTree.set("parameters/conditions/Death", !Alive())
		
	AnimTree.get("parameters/playback")
			
	
		
func TargetInRange():
	return global_position.distance_to(Player.global_position) < AttackRange
	
func HitFinished():
	if global_position.distance_to(Player.global_position) < AttackRange + 1.0:
		var dir = global_position.direction_to(Player.global_position)
		var ataka = Bullet.instantiate()
		var world = get_tree().get_root().get_child(0)
		ataka.position = $RayCast3D.global_position
		#ataka.seth(global_position.distance_to(Player.global_position))
		ataka.setvelocity($".".global_position, Player.global_position)
		world.add_child(ataka)
		if raycast.is_colliding():
			var hit = raycast.get_collider()
			if hit.is_in_group("Player"):
				Player.Hit(dir)

func DeadAnim():
	var Ammoinstance = AmmoBox.instantiate()
	Ammoinstance.position = global_position + Vector3(0,2,0)
	get_parent().get_parent().add_child(Ammoinstance)
	
	var Lifeinstance = Life.instantiate()
	Lifeinstance.position = global_position + Vector3(0.5,2,0)
	get_parent().get_parent().add_child(Lifeinstance)
	
	var Upgradeinstance = Upgrade.instantiate()
	Upgradeinstance.position = global_position + Vector3(0,2,0.5)
	get_parent().get_parent().add_child(Upgradeinstance)
	
	
	queue_free()
	
func Alive():
	return alive
	
func HitS(Damage, _Direction:= Vector3.ZERO, _Position:= Vector3.ZERO):
	#var HitPosition = _Position - get_global_transform().origin
	#print("Health: " + str(Health));
	Health -=Damage
	#print("Target Health: " + str(Health))
	if Health > 0:
		bar.scale.x = MaxHealth * Health / fullhealth
	if Health <= 0:
		bar.visible = false
		emit_signal("Dead")
		alive = false
	
	velocity = _Direction * 30
	move_and_slide()
		
func Hurt():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	#print(safe_velocity)
	
	if (Health > 0):
		velocity = safe_velocity * Speed
		move_and_slide()
	
	

	
