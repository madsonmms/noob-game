class_name AttackState
extends State

var chasing_component : ChasingComponent

func Enter():
	#-- Lógica global --#
	actor.velocity = Vector2.ZERO #Travar movimento enquanto ataca
	chasing_component = actor.get_component("ChasingComponent")
	
	if chasing_component:
		if chasing_component.target_lost.is_connected(_on_target_lost) == false:
			chasing_component.target_lost.connect(_on_target_lost)
	
	if actor is Player1 and player.weapon:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
		actor.hurtbox.monitoring = true #Liga o monitoramento da hurtbox
	else:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
	
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT) # Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	
	
func Exit():
	if chasing_component:
		if chasing_component.target_lost.is_connected(_on_target_lost):
			chasing_component.target_lost.disconnect(_on_target_lost)
	
	if actor is Player1:
		if actor.direction != Vector2.ZERO:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
	else:
		check_distance()
	
	pass

func _on_attack_finished(anim_name: String):
	if anim_name == "Attack":
		actor.attacking = false
		actor.hurtbox.monitoring = false

func _on_target_lost() -> void:
	actor.attacking = false
	if actor.direction == Vector2.ZERO:
		emit_signal("Transitioned", self, "IdleState")
	else:
		emit_signal("Transitioned", self, "ChasingState")
