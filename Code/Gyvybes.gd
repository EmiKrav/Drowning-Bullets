extends RigidBody3D

var life = 10
@onready var player = get_parent().get_parent().get_parent().get_node("%Player")


func Collectible():
	Global.LifePakelta(life)
	player.lifeUpdate()
	queue_free()

