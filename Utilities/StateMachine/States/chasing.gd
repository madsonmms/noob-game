class_name Chasing 
extends Actor

var direction = chasing_handler(actor, player)
@export var chasing_speed : float

func Enter():
	_check_distance(direction)
	
func Physics_Update(_delta: float) -> void:
	
	direction = chasing_handler(actor, player)
	
	if direction:
		_check_distance(direction)
		actor.velocity = - direction * actor.move_speed * chasing_speed
		actor.move_and_slide()
		

func _check_distance(direction) -> void:
	if direction and direction.length() > 50:
		emit_signal("Transitioned", self, "Wander")
	return
