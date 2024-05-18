extends Node3D

const SPEED = 150.0
var velocity = Vector3.ZERO 


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

#func seth(hei):
	#$MeshInstance3D.mesh.height = hei
	
