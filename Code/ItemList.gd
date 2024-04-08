extends ItemList

@onready var guns = get_node("%GunList")

@export var weapons: Array[Weapons_Resource]

var itemsel = null

var gunsel = null


var item : String
var gun : String
var ind = 0
func _ready():
	if Global.upgradai.size() != null:
		for i in Global.upgradai:
			for y in i:
				item += str(y) + " "
			add_item(item,null,true)
			item = "" 
	for weapon in weapons:
		gun += weapon.Weapon_Name + '\n'+ " Damage: " + str(weapon.Damage) + '\n'+ " Magazine: " + str(weapon.Magazine) + '\n'+ " Max Ammo: " + str(weapon.Max_Ammo) 
		guns.add_item(gun,null,true)
		gun =""


func _on_atgal_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	queue_free()


func _on_button_pressed():
	if(itemsel != null && gunsel != null):
		if (Global.upgradai[itemsel][0] == "Damage"):
			weapons[gunsel].Damage += Global.upgradai[itemsel][1]
		if (Global.upgradai[itemsel][0] == "Magazine"):
			weapons[gunsel].Magazine += Global.upgradai[itemsel][1]
		if (Global.upgradai[itemsel][0] == "Max Ammo"):
			weapons[gunsel].Max_Ammo += Global.upgradai[itemsel][1]
		
		Global.UpgradeSunaudota(itemsel)
		clear()
		if Global.upgradai.size() != null:
			for i in Global.upgradai:
				for y in i:
					item += str(y) + " "
				add_item(item,null,true)
				item = "" 
		guns.clear()
		for weapon in weapons:
			gun += weapon.Weapon_Name + '\n'+ " Damage: " + str(weapon.Damage) + '\n'+ " Magazine: " + str(weapon.Magazine) + '\n'+ " Max Ammo: " + str(weapon.Max_Ammo)
			guns.add_item(gun,null,true)
			gun =""


func _on_item_selected(index):
	itemsel = index


func _on_gun_list_item_selected(index):
	gunsel = index
