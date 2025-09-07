class_name SpriteHandler
extends Node

@export var sprites : Array[Sprite2D]

func _get_sprite_name(name : String) -> Sprite2D:
	for s in sprites:
		if s.name == name:
			return s
		
	return null

func show_sprite(name: String, direction : Vector2 = Vector2.LEFT):
	
	var sprite = _get_sprite_name(name)
	
	for s in sprites:
		s.visible = s.name == name
		
	if direction.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
			
