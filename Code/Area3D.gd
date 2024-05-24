extends Area3D



func _on_body_entered(body):
	if body.has_method("Collectible"):
		body.Collectible()
		Music.playsoundPickUP(4)
	
