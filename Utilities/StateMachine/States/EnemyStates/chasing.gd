class_name ChasingState
extends State

var chasing_component : ChasingComponent

func Enter():
	print_debug("entrei em chasing")
	chasing_component = actor.get_component("ChasingComponent")
	
	pass
	
func Update(_delta : float) -> void:
	if chasing_component:
		if chasing_component.target_lost.is_connected(_on_target_lost):
			chasing_component.target_lost.disconnect(_on_target_lost)
		chasing_component.target_lost.connect(_on_target_lost)

func _on_target_lost() -> void:
	print_debug("target lost")
	emit_signal("Transitioned", self, "IdleState")
	pass
