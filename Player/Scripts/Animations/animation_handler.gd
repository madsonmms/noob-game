class_name AnimationHandler extends Node

@export var animation_tree : AnimationTree
@export var actor : CharacterBody2D
@export var animation_player : AnimationPlayer

signal animation_finished(anim_name: StringName)

func _ready() -> void:
	animation_tree.active = true
	
func play( state: String, blend: Vector2 = Vector2.ZERO ) -> void:
	
	if blend.x != 0:
		if blend.x < 0:
			actor.sprite.scale.x = -1
		else:
			actor.sprite.scale.x = 1
	
	animation_tree.set("parameters/%s/blend_position" % state, blend)

	
	if state == "Attack":
		var anim_length = animation_player.get_animation("attack_side").length
		await get_tree().create_timer(anim_length).timeout
		emit_signal("animation_finished", "Attack")

func _on_animation_finished(from: String, to: String) -> void:
	pass
