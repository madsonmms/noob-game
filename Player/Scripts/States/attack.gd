extends Actor

@onready var hurt_box : HurtBox = $"../../Interactions/HurtBox"

func Enter():
	#Travar movimento enquanto ataca
	actor.velocity = Vector2.ZERO
	
	# Toca a animação de ataque na direção correta
	actor.animation_handler.play("Attack", actor.last_direction)
	
	# Conecta ao sinal do AnimationHandler (se ainda não estiver conectado)
	actor.animation_handler.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)
	
	#Timer pra ligar a hurtbox
	await get_tree().create_timer( 0.075 ).timeout
	
	#Liga o monitoramento da hurbox
	hurt_box.monitoring = true

func Exit():
	pass
	
func _on_attack_finished(anim_name: String):
	if anim_name == "Attack":
		actor.attacking = false
		hurt_box.monitoring = false
		
		if actor.direction != Vector2.ZERO:
			emit_signal("Transitioned", self, "Walk")
		else:
			emit_signal("Transitioned", self, "Idle")
		
