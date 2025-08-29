class_name ChasingState
extends ActorsConfig

var direction = chasing_handler(actor, player)

@export var chasing_speed : float
@export var animation_handler : AnimationHandler

func Enter():
	_check_distance(direction)
	
func Physics_Update(_delta: float) -> void:
	var move_speed = actor.move_speed
	direction = chasing_handler(actor, player)
	
	if direction:
		_check_distance(direction)
		actor.velocity = - direction.normalized() * move_speed * chasing_speed
		actor.move_and_slide()
		animation_handler.play("Wander", - direction)

func _check_distance(direction) -> void:
	if direction and direction.length() > 50:
		emit_signal("Transitioned", self, "WanderState")
	return
