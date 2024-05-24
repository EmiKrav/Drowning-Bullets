extends Node3D

const SPEED = 60.0
var velocity = Vector3.ZERO 

@onready var emitter = get_tree().get_root().get_child(2)
@onready var wm = emitter.get_node("Player/MainCamera/Weapons_Manager")

func _ready():
	wm.naikintkulka.connect(naikint)

func _process(delta):
	position += velocity * delta	
	
func naikint():
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _on_timer_timeout():
	queue_free()
	
func setvelocity(pos, target):
	look_at_from_position(pos, target)
	velocity = position.direction_to(target) * SPEED
	
