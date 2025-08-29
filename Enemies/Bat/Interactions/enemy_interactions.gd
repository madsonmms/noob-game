class_name EnemyInteractions
extends Node2D

@onready var enemy : Enemy = $".."

func _ready() -> void:
	enemy.DirectionChanged.connect( UpdateDirection )
	pass
	
func UpdateDirection(new_dir : Vector2) -> void:
	match new_dir:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
			position.y = -8.0
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		Vector2.ZERO:
			rotation_degrees = 0
			
	pass
