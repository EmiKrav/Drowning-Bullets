extends ItemList

@onready var guns = get_node("%GunList")

@export var weapons: Array[Weapons_Resource]

@export var char : CharacterResource

		
var itemsel = null

var gunsel = null


var item : String
var gun : String
var ind = 0

var upgradeitem = "ginklai"

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
	if upgradeitem == "ginklai":
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
	else:
		if(itemsel != null && gunsel != null):
			if Global.kristalai[itemsel][1] > 0:
				if (Global.kristalai[itemsel][0] == "Geltonas"):
					char.UnderwaterBreath += 1
				if (Global.kristalai[itemsel][0] == "Raudonas"):
					char.MaxHealth += 1
				if (Global.kristalai[itemsel][0] == "Žalias"):
					char.UnderwaterBreath += 1
					char.MaxHealth += 1
				Global.KristalaiSunaudota(itemsel)
			clear()
			if Global.kristalai.size() != null:
				for i in Global.kristalai:
					for y in i:
						item += str(y) + " "
					add_item(item,null,true)
					item = "" 
			guns.clear()
			gun += str(char.Name) + '\n'+" HP: " + str(char.MaxHealth) + '\n'+ " Underwater time: " + str(char.UnderwaterBreath)
			guns.add_item(gun,null,true)
			gun =""


func _on_item_selected(index):
	itemsel = index


func _on_gun_list_item_selected(index):
	gunsel = index


func _on_change_pressed():
	if upgradeitem == "ginklai":
		upgradeitem = "veikejas"
		if Global.kristalai.size() != null:
			clear()
			for i in Global.kristalai:
				for y in i:
					item += str(y) + " "
				add_item(item,null,true)
				item = "" 
			guns.clear() 			
			gun += str(char.Name) + '\n'+" HP: " + str(char.MaxHealth) + '\n'+ " Underwater time: " + str(char.UnderwaterBreath)
			guns.add_item(gun,null,true)
			gun =""
		$"../../../VBoxContainer5/Change".text = "Veikėjas"
	elif upgradeitem == "veikejas":
		upgradeitem = "ginklai"
		if Global.upgradai.size() != null:
			clear()
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
		$"../../../VBoxContainer5/Change".text = "Ginklai"
