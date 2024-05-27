extends GPUParticles3D

func _ready():
	$".".emitting = true
	await get_tree().create_timer(5).timeout
	queue_free()
