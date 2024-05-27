extends Decal


func _ready():
	var fade = get_tree().create_tween()
	fade.parallel().tween_property($".","scale", Vector3(2.0,2.0,2.0), 1)
	fade.parallel().tween_property($".","modulate:a", 0, 1)
	await fade.finished
	queue_free()
