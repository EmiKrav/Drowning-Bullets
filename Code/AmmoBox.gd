extends RigidBody3D

var bullets = 10
@onready var player = get_parent().get_parent().get_parent().get_node("%Player")


func Collectible():
	Global.AmmoPakelta(bullets)
	player.AmmoUpdate()
	queue_free()


