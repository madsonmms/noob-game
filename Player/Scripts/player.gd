class_name Player1
extends CharacterBody2D

@export var move_speed: float = 100.0
var direction : Vector2 = Vector2.ZERO

@export var animation_tree : AnimationTree
@export var state_machine : StateMachine

func _ready() -> void:
	animation_tree.active = true
