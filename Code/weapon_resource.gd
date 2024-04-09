extends Resource

class_name Weapons_Resource

@export var Weapon_Name: String
@export var Activate_Anim: String
@export var Shoot_Anim: String
@export var Reload_Anim: String
@export var Deactivate_Anim: String
@export var Zoom_Anim: String
@export var Zoom_AnimSauti: String

@export var Current_Ammo: int
@export var Reserve_Ammo: int
@export var Magazine: int
@export var Max_Ammo: int

@export var Auto_Fire: bool

@export_flags("HitScan") var Type
@export var WeaponRange : int
@export var Damage : int
