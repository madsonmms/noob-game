class_name ChasingState
extends ActorsConfig

@export var chasing_speed : float
@export var animation_handler : AnimationHandler

func Enter():
	show_sprite("Idle")
	pass
	
func Physics_Update(_delta: float) -> void:
	var move_speed = actor.move_speed
	var sprite_direction = sprite_direction("Idle",chasing_handler(actor, player).normalized())
	
	if check_distance():
		actor.velocity = - actor.direction.normalized() * move_speed * chasing_speed
		actor.move_and_slide()
		animation_handler.play("Wander", sprite_direction)
