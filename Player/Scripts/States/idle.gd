extends Actor

func Enter():
	# Seta a animação Idle
	actor.animation_handler.play("Idle", actor.last_direction)

func Physics_Update(_delta: float) -> void:
	var input_vector = actor.get_input_direction()

	if input_vector != Vector2.ZERO:
		emit_signal("Transitioned", self, "Walk")
	elif actor.attacking == true:
		emit_signal("Transitioned", self, "Attack")
