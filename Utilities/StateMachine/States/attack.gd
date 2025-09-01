class_name AttackState
extends ActorsConfig

func Enter():
	#-- Lógica global --#
	actor.attacking = true
	actor.velocity = Vector2.ZERO #Travar movimento enquanto ataca
	
	if actor is Player1:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
	else:
		var sprite_direction = sprite_direction("Attack", chasing_handler(actor, player).normalized())
		actor.animation_handler.play("Attack", sprite_direction) # Toca a animação de ataque na direção correta
		
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT) # Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	actor.hurt_box.monitoring = true #Liga o monitoramento da hurtbox
	
func Exit():
	pass
	
func _on_attack_finished(anim_name: String):
	if anim_name == "Attack":
		actor.attacking = false
		actor.hurt_box.monitoring = false
		
		if actor is Player1:
			if actor.direction != Vector2.ZERO:
				emit_signal("Transitioned", self, "WalkState")
			else:
				emit_signal("Transitioned", self, "IdleState")
		else:
			check_distance()
