class_name ChasingState
extends State

func Enter():
	show_sprite("Idle")
	pass
	
func Physics_Update(_delta: float) -> void:
	var move_speed = actor.move_speed
	var chasing_speed = actor.chasing_speed
	#var sprite_direction = sprite_direction("Idle", chasing_handler(actor, player).normalized())
	
	if check_distance():
		actor.velocity = - actor.direction.normalized() * move_speed * chasing_speed
		actor.move_and_slide()
		actor.animation_handler.play("Wander", sprite_direction)
