class_name WanderState
extends State

var wander_direction : Vector2
var wander_time : float

func Enter():
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
	
	#if chasing_handler(actor, player).length() < 50:
		#emit_signal("Transitioned", self, "ChasingState")
	#elif actor.dead:
		#emit_signal("Transitioned", self, "DeaadState")
