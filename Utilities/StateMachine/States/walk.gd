class_name WalkState
extends ActorsConfig

func Enter():
	pass

func Physics_Update(_delta: float) -> void:
	var animation = actor.animation_handler
	var attacking = actor.attacking
		
	if not attacking:
		actor.velocity = actor.direction * actor.move_speed
		actor.move_and_slide()
		animation.play("Walk", actor.direction)
	
	if actor.direction == Vector2.ZERO:
		emit_signal("Transitioned", self, "IdleState")
	elif actor.attacking == true:
		emit_signal("Transitioned", self, "AttackState")
