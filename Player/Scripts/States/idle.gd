extends PlayerState

func Enter():
	# Seta a animação Idle
	actor.animation_tree.set("parameters/Idle/blend_position", Vector2.ZERO)
	actor.animation_tree.set("parameters/conditions/idle", true)
	actor.animation_tree.set("parameters/conditions/run", false)


func Physics_Update(_delta: float) -> void:
	var input_vector = get_input_direction()

	if input_vector != Vector2.ZERO:
		emit_signal("Transitioned", self, "Walk")
