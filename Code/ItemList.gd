extends ItemList

@onready var guns = get_node("%GunList")
@onready var itemSprite = preload("res://Models/guns-p.png")
@onready var itemSprite2 = preload("res://Models/guns-34272_1920.png")
@onready var itemSprite3 = preload("res://Models/target-158129_1280.png")
@onready var itemSprite4 = preload("res://Models/ammunition-147535_1280.png")
@onready var itemSprite5 = preload("res://Models/ammo.png")
@onready var itemSprite6 = preload("res://Models/godotchar.png")
@onready var itemSprite7 = preload("res://Models/heart.png")
@onready var itemSprite8 = preload("res://Models/fish-3487738_1280.png")
@onready var itemSprite9 = preload("res://Models/stone2.png")
@onready var itemSprite10 = preload("res://Models/stone3.png")
@onready var itemSprite11 = preload("res://Models/stone-576371_1280.png")

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
				if str(y) == "Damage":
					add_icon_item(itemSprite3)
				if str(y) == "Magazine":
					add_icon_item(itemSprite4)
				if str(y) == "Max Ammo":
					add_icon_item(itemSprite5)
			add_item(item,null,true)
			item = "" 
	for weapon in weapons:
		gun = weapon.Weapon_Name 
		if weapon.Weapon_Name == "Pistol":
			guns.add_item(gun,itemSprite,true)
		else:
			guns.add_item(gun,itemSprite2,true)
		gun = " Damage: " + str(weapon.Damage)
		guns.add_item(gun,itemSprite3,true)
		gun = " Magazine: " + str(weapon.Magazine)
		guns.add_item(gun,itemSprite4,true)
		gun = " Max Ammo: " + str(weapon.Max_Ammo) 
		guns.add_item(gun,itemSprite5,true)
		gun =""


func _on_atgal_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	queue_free()


func _on_button_pressed():
	if upgradeitem == "ginklai":
		if(itemsel != null && gunsel != null):
			if itemsel != 0:
				itemsel /= 2;
			if gunsel != 0:
				gunsel /=4
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
						if str(y) == "Damage":
							add_icon_item(itemSprite3)
						if str(y) == "Magazine":
							add_icon_item(itemSprite4)
						if str(y) == "Max Ammo":
							add_icon_item(itemSprite5)
					add_item(item,null,true)
					item = "" 
			guns.clear()
			for weapon in weapons:
				gun = weapon.Weapon_Name 
				if weapon.Weapon_Name == "Pistol":
					guns.add_item(gun,itemSprite,true)
				else:
					guns.add_item(gun,itemSprite2,true)
				gun = " Damage: " + str(weapon.Damage)
				guns.add_item(gun,itemSprite3,true)
				gun = " Magazine: " + str(weapon.Magazine)
				guns.add_item(gun,itemSprite4,true)
				gun = " Max Ammo: " + str(weapon.Max_Ammo) 
				guns.add_item(gun,itemSprite5,true)
				gun =""
	else:
		if(itemsel != null && gunsel != null):
			if itemsel != 0:
				itemsel /= 2;
			if gunsel != 0:
				gunsel /=4
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
						if str(y) == "Geltonas":
							add_icon_item(itemSprite9)
						if str(y) == "Žalias":
							add_icon_item(itemSprite10)
						if str(y) == "Raudonas":
							add_icon_item(itemSprite11)
					add_item(item,null,true)
					item = ""
			guns.clear()
			gun = str(char.Name) 
			guns.add_item(gun,itemSprite6,true)
			gun = " HP: " + str(char.MaxHealth)
			guns.add_item(gun,itemSprite7,true) 
			gun =" Underwater time: " + str(char.UnderwaterBreath)
			guns.add_item(gun,itemSprite8,true)
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
						if str(y) == "Geltonas":
							add_icon_item(itemSprite9)
						if str(y) == "Žalias":
							add_icon_item(itemSprite10)
						if str(y) == "Raudonas":
							add_icon_item(itemSprite11)
				add_item(item,null,true)
				item = ""
			guns.clear() 			
			gun = str(char.Name) 
			guns.add_item(gun,itemSprite6,true)
			gun = " HP: " + str(char.MaxHealth)
			guns.add_item(gun,itemSprite7,true) 
			gun =" Underwater time: " + str(char.UnderwaterBreath)
			guns.add_item(gun,itemSprite8,true)
			gun =""
		$"../../../VBoxContainer5/Change".text = "Veikėjas"
	elif upgradeitem == "veikejas":
		upgradeitem = "ginklai"
		if Global.upgradai.size() != null:
			clear()
			for i in Global.upgradai:
				for y in i:
					item += str(y) + " "
					if str(y) == "Damage":
						add_icon_item(itemSprite3)
					if str(y) == "Magazine":
						add_icon_item(itemSprite4)
					if str(y) == "Max Ammo":
						add_icon_item(itemSprite5)
				add_item(item,null,true)
				item = "" 
			guns.clear() 	
			for weapon in weapons:
				gun = weapon.Weapon_Name 
				if weapon.Weapon_Name == "Pistol":
					guns.add_item(gun,itemSprite,true)
				else:
					guns.add_item(gun,itemSprite2,true)
				gun = " Damage: " + str(weapon.Damage)
				guns.add_item(gun,itemSprite3,true)
				gun = " Magazine: " + str(weapon.Magazine)
				guns.add_item(gun,itemSprite4,true)
				gun = " Max Ammo: " + str(weapon.Max_Ammo) 
				guns.add_item(gun,itemSprite5,true)
				gun =""
		$"../../../VBoxContainer5/Change".text = "Ginklai"
