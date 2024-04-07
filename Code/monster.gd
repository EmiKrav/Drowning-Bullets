extends CharacterBody3D


var MaxHealth = 5
var Health = 5
const  AttackRange = 4
var stuck = false
var StateMachine

#var Player = null
#@export var PlayerPath : NodePath
var alive = true
@onready var Player
const  Speed = 5.0
@onready var NavAgent = $NavigationAgent3D
@onready var AnimTree = $AnimationTree
@onready var bar = $Gyvyb
var fullhealth = Health

signal Dead

func _ready():
	StateMachine =AnimTree.get("parameters/playback")
	MaxHealth = bar.scale.x

	
func _physics_process(_delta):
	

		velocity = Vector3.ZERO	
		
		match StateMachine.get_current_node():
			"Fast_Flying":
				NavAgent.set_target_position(Player.global_transform.origin)
				var NextNavPoint = NavAgent.get_next_path_position()
				velocity = (NextNavPoint-global_transform.origin).normalized() * Speed
					
				look_at(Vector3(Player.global_position.x  + velocity.x, Player.global_position.y + velocity.y,
						Player.global_position.z + velocity.z), Vector3.UP)
			"Punch":
				look_at(Vector3(Player.global_position.x, Player.global_position.y,
						Player.global_position.z), Vector3.UP)
							
							
		AnimTree.set("parameters/conditions/Punch", TargetInRange())
		AnimTree.set("parameters/conditions/Fly", !TargetInRange())
		AnimTree.set("parameters/conditions/Dead", !Alive())
		
		AnimTree.get("parameters/playback")
			
		move_and_slide()
		
func TargetInRange():
	return global_position.distance_to(Player.global_position) < AttackRange
	
func HitFinished():
	if global_position.distance_to(Player.global_position) < AttackRange + 1.0:
		var dir = global_position.direction_to(Player.global_position)
		Player.Hit(dir)

func DeadAnim():
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
	
	velocity = _Direction * 10
	move_and_slide()
		
func Hurt():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	#print(safe_velocity)
	
	if (Health > 0):
		velocity = safe_velocity * Speed
		move_and_slide()
	
	

