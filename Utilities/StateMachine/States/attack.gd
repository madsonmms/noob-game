class_name AttackState
extends State

func Enter():
	#-- Lógica global --#
	actor.velocity = Vector2.ZERO #Travar movimento enquanto ataca
	
	if actor is Player1 and player.weapon:
		actor.attacking = true
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
		actor.weapon.hurt_box.monitoring = true #Liga o monitoramento da hurtbox
	elif actor is not Player1:
		actor.attacking = true
		var sprite_direction = sprite_direction("Attack", chasing_handler(actor, player).normalized())
		actor.animation_handler.play("Attack", sprite_direction) # Toca a animação de ataque na direção correta
		actor.hurt_box.monitoring = true #Liga o monitoramento da hurtbox
	else:
		actor.animation_handler.play("Attack", actor.last_direction) # Toca a animação de ataque na direção correta
	
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT) # Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	
	
func Exit():
	pass

func _on_attack_finished(anim_name: String):
	if anim_name == "Attack" and actor is Player1 and player.weapon:
		actor.attacking = false
		actor.weapon.hurt_box.monitoring = false
	elif actor is not Player1:
		actor.attacking = false
		actor.hurt_box.monitoring = false
	else:
		actor.attacking = false
	
	
	if actor is Player1:
		if actor.direction != Vector2.ZERO:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
	else:
		check_distance()
