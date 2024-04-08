extends Node

var banga = 1
var Ammo = 0
var Rasti = 0
var life : float = 0
var upgradai : Array

func _ready():
	pass

func KitaBanga():
	Global.banga += 1

func Reset():
	Global.banga = 1
	Global.Ammo = 0
	Global.life = 0
	Global.Rasti = 0

func AmmoPakelta(ammo):
	Global.Ammo += ammo

func AmmoSunaudota(ammo):
	Global.Ammo -= ammo 

func LifePakelta(Hp):
	Global.life += Hp

func LifeSunaudota(Hp):
	Global.life -= Hp 
	
func UpgradeSunaudota(i):
	Global.upgradai.remove_at(i)
	
func UpgradePrideta(i):
	if Global.upgradai.size() != null:
		Global.upgradai.append(i)
	else :
		Global.upgradai[0] = i
		
func RastiDaiktai():
	Global.Rasti += 1

