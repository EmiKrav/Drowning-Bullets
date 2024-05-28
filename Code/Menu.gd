extends Node3D

@onready var ezeras = preload("res://Scenes/ezeras.tscn")
@onready var arsenalas = preload("res://Scenes/Arsenalas.tscn")
@onready var sound = preload("res://Models/sound.png")
@onready var nosound = preload("res://Models/mute-1628277_1280.png")

func _ready():
	if Global.paleistas:
		$VideoStreamPlayer.queue_free()
		$CanvasLayer.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	get_tree().paused = false;
	if Music.muted:
		Music.MusicStop()
	if !Music.muted and Music.current() != 1:
		Music.play1()
		Music.filterback()
		
	if Music.muted == true:
		%Muzika.icon = nosound
		
	else:
		Music.muted = false
		%Muzika.icon = sound
		
	%HSlider.value = Music.Volume()

func _on_button_pressed():
	Music.MusicStop()
	get_tree().change_scene_to_packed(ezeras)

func _on_quit_pressed():
	get_tree().quit()


func _on_arsenal_pressed():
	get_tree().change_scene_to_packed(arsenalas)


func _on_muzika_pressed():
	if Music.muted == false:
		Music.MusicStop()
		Music.muted = true
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_color",Color(0.643, 0, 0.008))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_pressed_color",Color(0.643, 0, 0.008))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_hover_color",Color(0.643, 0, 0.008))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_focus_color",Color(0.643, 0, 0.008))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_hover_pressed_color",Color(0.643, 0, 0.008))
		%Muzika.icon = nosound
		
	else:
		Music.muted = false
		Music.play1()
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_color", Color(0, 0.404, 0.22))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_pressed_color",Color(0, 0.404, 0.22))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_hover_color",Color(0, 0.404, 0.22))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_focus_color",Color(0, 0.404, 0.22))
		#$CanvasLayer/Panel/VBoxContainer/Muzika.set("theme_override_colors/font_hover_pressed_color",Color(0, 0.404, 0.22))
		%Muzika.icon = sound


func _on_h_slider_value_changed(value):
	Music.ChangeVolume(value)
	
