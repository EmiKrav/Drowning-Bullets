extends RigidBody3D

var Health = 10

func HitS(Damage):
	Health -=Damage
	#print("Target Health: " + str(Health))
	if Health <= 0:
		queue_free()
