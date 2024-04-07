extends CanvasLayer

@onready var CurrenrtWeaponLabel = $VBoxContainer/HBoxContainer/CurrentWeapon
@onready var CurrenrtAmmoLabel = $VBoxContainer/HBoxContainer2/CurrentAmmo
#@onready var CurrenrtWeaponStackLabel = $VBoxContainer/HBoxContainer3/WeaponStack
@onready var Life = $VBoxContainer2/HBoxContainer3/Life
@onready var wave = $VBoxContainer3/HBoxContainer3/Wave

func _ready():
		Life.set_text("100")
		wave.set_text("Banga: " +str(Global.banga))

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
