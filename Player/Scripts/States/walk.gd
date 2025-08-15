extends PlayerState

func Enter():
	actor.animation_tree.set("parameters/conditions/Idle", false)
	actor.animation_tree.set("parameters/conditions/Run", true)

func Physics_Update(_delta: float) -> void:
	var input_vector = get_input_direction()
	
	if input_vector == Vector2.ZERO:
		emit_signal("Transitioned", self, "Idle")
		return

	# Movimento
	actor.velocity = input_vector * actor.move_speed
	actor.move_and_slide()

	# Atualiza blend de animação
	actor.animation_tree.set("parameters/Run/blend_position", input_vector)
