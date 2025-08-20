extends Actor

func Enter():
	#
	###Travar movimento enquanto ataca
	#actor.velocity = Vector2.ZERO
	
	# Toca a animação de ataque na direção correta
	actor.animation_handler.play("Attack", actor.last_direction)
	
	# Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)

func Exit():
	pass
	
func _on_attack_finished(anim_name: String):
	if anim_name == "Attack":
		print_debug(actor.direction)
		actor.attacking = false
		if actor.direction == Vector2.ZERO:
			emit_signal("Transitioned", self, "Idle")
		elif actor.direction != Vector2.ZERO:
			emit_signal("Transitioned", self, "Walk")
