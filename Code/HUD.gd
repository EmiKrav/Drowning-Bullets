extends CanvasLayer

@onready var CurrenrtWeaponLabel = $VBoxContainer/HBoxContainer/CurrentWeapon
@onready var CurrenrtAmmoLabel = $VBoxContainer/HBoxContainer2/CurrentAmmo
#@onready var CurrenrtWeaponStackLabel = $VBoxContainer/HBoxContainer3/WeaponStack



func _on_weapons_manager_update_ammo(Ammo):
	CurrenrtAmmoLabel.set_text(str(Ammo[0])+" /" + str(Ammo[1]))


#func _on_weapons_manager_update_weapon_stack(Weapon_stack):
#	CurrenrtWeaponStackLabel.set_text("")
#	for i in Weapon_stack:
#		CurrenrtWeaponStackLabel.text += "\n"+i


func _on_weapons_manager_weapon_changed(Weapon_Name):
	CurrenrtWeaponLabel.set_text(Weapon_Name)
