extends Node

var banga = 1
var Ammo = 0
var Rasti = 0
var life : float = 0
var upgradai : Array
var kristalai = [null,null,null]

var geltkrist = 0;
var rautkrist = 0;
var zaltkrist = 0;


func _ready():
	Global.kristalai[0] = ["Raudonas", geltkrist]
	Global.kristalai[1] = ["Geltonas", rautkrist]
	Global.kristalai[2] = ["Žalias", zaltkrist]

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
		
func KristalaiSunaudota(i):
	if i == 1:
		geltkrist -= 1
		Global.kristalai[1][1] = geltkrist
	if i == 0:
		rautkrist -= 1
		Global.kristalai[0][1] = rautkrist 
	if i == 2:
		zaltkrist -= 1
		Global.kristalai[2][1] = zaltkrist  
	
func KristalaiPrideta(i):
	if i.has("Geltonas"):
		geltkrist += 1
		Global.kristalai[1][1] = geltkrist
	if i.has("Raudonas"):
		rautkrist += 1
		Global.kristalai[0][1] = rautkrist 
	if i.has("Žalias"):
		zaltkrist += 1
		Global.kristalai[2][1] = zaltkrist  
		
func RastiDaiktai():
	Global.Rasti += 1

