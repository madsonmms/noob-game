class_name DeathState
extends State

@export var animation_handler : AnimationHandler

func Enter():
	
	var sprite_direction = sprite_direction("Death", actor.last_direction)
	
	animation_handler.play("Death", sprite_direction)
	
	if not actor.animation_handler.animation_finished.is_connected(_on_death_finished):
		actor.animation_handler.animation_finished.connect(_on_death_finished, CONNECT_ONE_SHOT)
	
	pass

func _on_death_finished(anim_name : String) -> void:
	if anim_name == "Death":
		actor.drop()
