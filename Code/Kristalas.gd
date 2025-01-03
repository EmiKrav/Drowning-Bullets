extends Node3D

@onready var player

var tipai = ["Geltonas", "Raudonas", "Žalias"]
var rng
var ind
var upgraidas
var col = true

func _ready():
	rng = RandomNumberGenerator.new()
	ind = rng.randi_range(0, 2)
	upgraidas = [tipai[ind], 1]
	if tipai[ind]== "Geltonas":
		$Area3D/low.get_active_material(0).albedo_color= Color(0.698, 0.478, 0.071)
	if tipai[ind]== "Raudonas":
		$Area3D/low.get_active_material(0).albedo_color=  Color(0.433, 0, 0.075)
	if tipai[ind]== "Žalias":
		$Area3D/low.get_active_material(0).albedo_color=  Color(0.115, 0.508, 0)
	
	var mat = $Area3D/low.get_active_material(0).duplicate()
	$Area3D/low.set("surface_material_override/0", mat)
	
func MiningP():
	Global.KristalaiPrideta(upgraidas)
	Global.RastiDaiktai()
	player.UpgradeUpdate()
	
func _on_area_3d_area_entered(area):
	if player.get_node("%Weapons_Manager").CollectKristalus():
			Music.playMiningsound(5)
	if col == true:
		col = false
		if player.get_node("%Weapons_Manager").CollectKristalus():
			Music.playMiningsound(5)
			if $".".scale > Vector3(0.00075, 0.00075, 0.00075):
				$".".scale /=2
				MiningP()
			else:
				MiningP()
				queue_free()


func _on_area_3d_area_exited(area):
	await get_tree().create_timer(2.0).timeout
	col = true
