extends CharacterBody3D


var Health = 1
const  AttackRange = 4

var StateMachine

#var Player = null
#@export var PlayerPath : NodePath
@onready var Player
const  Speed = 2.0
@onready var NavAgent = $NavigationAgent3D
@onready var AnimTree = $AnimationTree

signal Dead

func _ready():
	StateMachine =AnimTree.get("parameters/playback")

func _process(_delta):
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
	
	AnimTree.get("parameters/playback")
		
	move_and_slide()
		
func TargetInRange():
	return global_position.distance_to(Player.global_position) < AttackRange
	
func HitFinished():
	if global_position.distance_to(Player.global_position) < AttackRange + 1.0:
		var dir = global_position.direction_to(Player.global_position)
		Player.Hit(dir)
	
func HitS(Damage, _Direction:= Vector3.ZERO, _Position:= Vector3.ZERO):
	#var HitPosition = _Position - get_global_transform().origin
	#print("Health: " + str(Health));
	Health -=Damage
	#print("Target Health: " + str(Health))
	if Health <= 0:
		emit_signal("Dead")
		queue_free()
	
	#if _Direction != Vector3.ZERO:
		#apply_impulse((_Direction*Damage), HitPosition)
		
		
func Hurt():
	pass
