extends Decal

func _on_timer_timeout():
	var fade = get_tree().create_tween()
	fade.tween_property($".","modulate:a", 0, 1.5)
	await  fade.finished
	queue_free()
