extends CollisionShape3D

var Health = 5


func HitS(Damage, _Direction:= Vector3.ZERO, _Position:= Vector3.ZERO):
	var HitPosition = _Position - get_global_transform().origin
	print("Health: " + str(Health));
	Health -=Damage
	#print("Target Health: " + str(Health))
	if Health <= 0:
		queue_free()
	
	#if _Direction != Vector3.ZERO:
		#apply_impulse((_Direction*Damage), HitPosition)
		
func Hurt():
	print("Health: " + str(Health));
