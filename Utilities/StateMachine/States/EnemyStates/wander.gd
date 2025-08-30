class_name WanderState
extends ActorsConfig

@export var animation_handler : AnimationHandler

var move_direction : Vector2
var wander_time : float      


func Enter():
	_randomize_wander()
	
func _randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	
func Update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		_randomize_wander()
		
func Physics_Update(_delta: float) -> void:
	actor.velocity = move_direction * actor.move_speed
	actor.move_and_slide()
	animation_handler.play("Wander", move_direction)
	
	if chasing_handler(actor, player).length() < 50:
		emit_signal("Transitioned", self, "ChasingState")
