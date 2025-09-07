class_name AttackState
extends State

func Enter():
	print_debug("entered attack")
	#-- Lógica global --#
	actor.velocity = Vector2.ZERO #Travar movimento enquanto ataca
	
	if actor is Player1 and player.weapon:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
		actor.hurtbox.monitoring = true #Liga o monitoramento da hurtbox
	else:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
	
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT) # Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	
	
func Exit():
	pass

func _on_attack_finished(anim_name: String):
	if anim_name == "Attack":
		actor.attacking = false
		actor.hurtbox.monitoring = false
	
	if actor is Player1:
		if actor.direction != Vector2.ZERO:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
	else:
		check_distance()
