class_name IdleState
extends ActorsConfig

var idle_direction : Vector2
var idle_timer : Timer = Timer.new()

func Enter():
	if actor is not Player1:
		var timer_component = actor.get_node("TimerComponent")

		timer_component.start_timer(randf_range(1.0, 3.0), func():
			var idle_or_wander = randi() % 2 == 0
			if idle_or_wander:
				emit_signal("Transitioned", self, "WanderState")
			else:
				emit_signal("Transitioned", self, "IdleState")
		)
		
	# Seta a animação Idle
	actor.animation_handler.play("Idle", actor.last_direction)

func Physics_Update(_delta: float) -> void:
	
	var player_direction = player.get_direction()
	
	if player_direction != Vector2.ZERO and actor is Player1:
		emit_signal("Transitioned", self, "WalkState")
	elif actor.attacking == true:
		emit_signal("Transitioned", self, "AttackState")
