extends CanvasLayer

@onready var CurrenrtWeaponLabel = $VBoxContainer/HBoxContainer/CurrentWeapon
@onready var CurrenrtAmmoLabel = $VBoxContainer/HBoxContainer2/CurrentAmmo
#@onready var CurrenrtWeaponStackLabel = $VBoxContainer/HBoxContainer3/WeaponStack
@onready var Life = $VBoxContainer2/HBoxContainer3/Life
@onready var wave = $VBoxContainer3/HBoxContainer4/Wave
@onready var ReserveLife = $VBoxContainer2/HBoxContainer4/ReserveLife
@onready var ReserveAmmo = $VBoxContainer/HBoxContainer3/PickedUp
@onready var Upgrades = $VBoxContainer3/HBoxContainer3/Upgrades
@onready var crosshair = $TextureRect

@export var zoomo : CompressedTexture2D
@export var bezoomo : CompressedTexture2D

@export var characterResource: CharacterResource


func _ready():
		Life.set_text(str(characterResource.MaxHealth))
		wave.set_text("Banga: " +str(Global.banga))
		ReserveLife.set_text("Gėrymai: " +str(Global.life))
		ReserveAmmo.set_text("Kišenėj: " +str(Global.Ammo))
		Upgrades.set_text("Rasti" + '\n' + "Daiktai: " +str(Global.Rasti))

func _on_weapons_manager_update_ammo(Ammo):
	CurrenrtAmmoLabel.set_text(str(Ammo[0])+" /" + str(Ammo[1]))


#func _on_weapons_manager_update_weapon_stack(Weapon_stack):
#	CurrenrtWeaponStackLabel.set_text("")
#	for i in Weapon_stack:
#		CurrenrtWeaponStackLabel.text += "\n"+i


func _on_weapons_manager_weapon_changed(Weapon_Name):
	CurrenrtWeaponLabel.set_text(Weapon_Name)



func _on_player_player_hit(Gyvybes):
	if Gyvybes >= 0: 
		Life.set_text(str(Gyvybes))


func _on_player_banga():
	wave.set_text("Banga: " +str(Global.banga))


func _on_player_life_replene(Gyvybes):
	Life.set_text(str(Gyvybes))
	ReserveLife.set_text("Gėrymai: " +str(Global.life/10))
	
func _on_player_ammo_rasta():
	ReserveAmmo.set_text("Kišenėj: " +str(Global.Ammo))
	


func _on_weapons_manager_ammo_rasta():
	ReserveAmmo.set_text("Kišenėj: " +str(Global.Ammo))
	


func _on_player_daiktas_rastas():
	Upgrades.set_text("Rasti" + '\n' + "Daiktai: " +str(Global.Rasti))



func _on_player_zoom(zom):
	if (zom):
		crosshair.texture = zoomo
	else :
		crosshair.texture = bezoomo
		
