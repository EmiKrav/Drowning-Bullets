extends Node

var music1 = load("res://Music/extremeaction.mp3")
var music2 = load("res://Music/happyrock.mp3")

@onready var sound = [load("res://Music/kulka.mp3"), 
load("res://Music/failure-drum-sound-effect-2-7184.mp3"),
load("res://Music/goodresult-82807.mp3"),
load("res://Music/laser-gun-81720.mp3"),
load("res://Music/pick-up.mp3"), 
load("res://Music/pickaxe.mp3"),
load("res://Music/power-up-sparkle-1-177983.mp3"),
load("res://Music/punch-2-37333.mp3"),
load("res://Music/1911-reload-6248.mp3")]

@onready var audio = load("res://Scenes/audio.tscn")

var sk = 0
var muted = false

func  play1():
	if muted == false:
		$Muzika.stream = music2
		$Muzika.play()
		sk = 1
	
func  play2():
	if muted == false:
		$Muzika.stream = music1
		$Muzika.play()
		sk = 2
	
func MusicStop():
	$Muzika.stream_paused = true
	
func MusicResume():
	$Muzika.stream_paused = false
	
func filterunderwater():
	$Muzika.bus = "Underwater"
func filterback():
	$Muzika.bus = "Master"

func  playsoundkulka(effect):
	if muted == false:
		var instance = audio.instantiate()
		instance.volume_db = 0;
		$".".add_child(instance)
		instance.volume_db = 0;
		sound[effect].loop = false
		instance.stream = sound[effect]
		#instance.volume_db += 50;
		instance.play()
	
	
func  playMiningsound(effect):
	if muted == false:
		$Sound.volume_db = 0;
		sound[effect].loop = false
		$Sound.stream = sound[effect]
		$Sound.volume_db += 30;
		$Sound.play()		
	
func  playsoundPickUP(effect):
	if muted == false:
		$Sound.volume_db = 0;
		$Sound.volume_db += 30;
		sound[effect].loop = false
		$Sound.stream = sound[effect]
		$Sound.play()	
	
func  playsounPunch(effect):
	if muted == false:
		$Sound.volume_db = 0;
		$Sound.volume_db += 30;
		sound[effect].loop = false
		$Sound.stream = sound[effect]
		$Sound.play()	
	
	
func  playsoundDeath(effect):
	if muted == false:
		$Sound.volume_db = 0;
		$Sound.volume_db += 30;
		sound[effect].loop = false
		$Sound.stream = sound[effect]
		$Sound.play()	
	
func  playsound(effect):
	if muted == false:
		sound[effect].loop = false
		$Sound.stream = sound[effect]
		$Sound.volume_db = 0;
		$Sound.play()	
	
func playsoundkulkacont(effect):
	if muted == false:
		$Sound.volume_db = 0;
		$Sound.stream = sound[effect]
		$Sound.play()
	
func SoundStop():
	$Sound.stop()

func current():
	return sk

func ChangeVolume(volume):
	$Sound.volume_db = volume
	$Muzika.volume_db = volume

func Volume():
	return $Sound.volume_db
