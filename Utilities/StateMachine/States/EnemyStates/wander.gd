class_name WanderState
extends State

var wander_direction : Vector2
var wander_time : float

var chasing_component : ChasingComponent

func Enter():
	print_debug("entered wandering")
	
	chasing_component = actor.get_component("ChasingComponent")
	
	if chasing_component:
		if chasing_component.target_detected.is_connected(_on_target_detected):
			chasing_component.target_detected.disconnect(_on_target_detected)
		chasing_component.target_detected.connect(_on_target_detected)
	
	_randomize_wander()
	pass
	
func _randomize_wander():
	wander_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(0,2)
	
	
func Update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		var continue_wander = randi() % 2 == 0
		
		if continue_wander == true:
			_randomize_wander()
		else:
			emit_signal("Transitioned", self, "IdleState")
	

func Physics_Update(_delta: float) -> void:
	
	var sprite_direction = sprite_direction("Idle", - wander_direction)
	
	actor.velocity = wander_direction * actor.move_speed
	actor.move_and_slide()
	
	actor.animation_handler.play("Wander", sprite_direction)

func _on_target_detected() -> void:
	print_debug("target detected")
	emit_signal("Transitioned", self, "ChasingState")

func _on_target_lost() -> void:
	# Se perder o alvo, continua no wander sem transição
	pass
