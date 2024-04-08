extends RigidBody3D

@onready var player = get_parent().get_parent().get_parent().get_node("%Player")

var tipai = ["Damage", "Magazine", "Max Ammo"]
var rng
var ind2
var ind
var upgraidas

func _ready():
	rng = RandomNumberGenerator.new()
	ind2 = rng.randi_range(1, 5)
	ind = rng.randi_range(0, 2)
	upgraidas = [tipai[ind], ind2]

func Collectible():
	Global.UpgradePrideta(upgraidas)
	Global.RastiDaiktai()
	player.UpgradeUpdate()
	queue_free()
