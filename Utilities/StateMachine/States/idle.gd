class_name IdleState
extends State

var idle_direction : Vector2
var idle_time : float

func Enter():
	# Seta a animação Idle
	actor.animation_handler.play("Idle", actor.last_direction)

func Physics_Update(_delta: float) -> void:
	
	if actor is not Player1:
		var idle_or_wander = randi() % 2 == 0
		
		if idle_or_wander == false:
			_randomize_idle()
		else:
			emit_signal("Transitioned", self, "WanderState")
	
	var player_direction = player.get_direction()
	
	if player_direction != Vector2.ZERO and actor is Player1:
		emit_signal("Transitioned", self, "WalkState")
	elif actor.attacking == true:
		emit_signal("Transitioned", self, "AttackState")

func _randomize_idle():
	idle_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	idle_time = randf_range(0,3)
