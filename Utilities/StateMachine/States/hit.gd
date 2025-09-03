class_name HitState
extends State

var knockback_force : float = 1000.0

func Enter():
	if actor is not Player1:
		actor.hit = true
		actor.velocity = (actor.global_position - player.global_position).normalized() * knockback_force
		actor.move_and_slide()
	pass

func Update(_delta: float):
	if chasing_handler(actor, player).length() < 50:
		emit_signal("Transitioned", self, "ChasingState")

func Exit():
	
	pass
