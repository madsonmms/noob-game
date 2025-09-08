class_name ChasingState
extends State

var chasing_component : ChasingComponent

func Enter():
	print_debug("entrei em chasing")
	chasing_component = actor.get_component("ChasingComponent")
	
	pass
	
func Update(_delta : float) -> void:
	
	#Checa se o alvo está no range de ataque e conecta com o sinal de desired distance do navagent2d
	if chasing_component:
		if chasing_component.target_in_range.is_connected(_on_target_in_range) == false:
			chasing_component.target_in_range.connect(_on_target_in_range)
		if chasing_component.target_lost.is_connected(_on_target_lost) == false:
			chasing_component.target_lost.connect(_on_target_lost)
	
	if chasing_component:
		if chasing_component.target_lost.is_connected(_on_target_lost):
			chasing_component.target_lost.disconnect(_on_target_lost)
		chasing_component.target_lost.connect(_on_target_lost)

func _on_target_lost() -> void:
	emit_signal("Transitioned", self, "IdleState")

func _on_target_in_range() -> void:
	emit_signal("Transitioned", self, "AttackState")
