extends Node3D


var count = 0

func _process(delta):
	if count == 10:
		count = 0
		get_tree().paused = false;
		if Music.muted:
			Music.MusicStop()
		if !Music.muted and Music.current() != 2:
			Music.play2()
		$"../../../Control/ColorRect".visible = false
		$"../../../Control/ColorRect".color = Color(0.639, 0.031, 0, 0.259)
		%Player.get_child(0).visible = true
		$"../../../Control/Label".visible = false
	if $"../../../Control/Label".visible:
		$"../../../Control/Label".text ="Loading..."
		await get_tree().create_timer(0.1).timeout
		$"../../../Control/Label".text ="Loading."
		

func _on_proton_scatter_10_build_completed():
	count+=1

func _on_proton_scatter_9_build_completed():
	count+=1


func _on_proton_scatter_2_build_completed():
	count+=1


func _on_proton_scatter_3_build_completed():
	count+=1


func _on_proton_scatter_4_build_completed():
	count+=1


func _on_proton_scatter_5_build_completed():
	count+=1


func _on_proton_scatter_6_build_completed():
	count+=1


func _on_proton_scatter_7_build_completed():
	count+=1


func _on_proton_scatter_8_build_completed():
	count+=1


func _on_proton_scatter_11_build_completed():
	count+=1
