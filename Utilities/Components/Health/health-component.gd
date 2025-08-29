class_name HealthComponent
extends Node

@export var MAX_HEALTH : float = 3

@export var hit_box_component : HitBoxComponent

var health : float

func _ready() -> void:
	health = MAX_HEALTH
	print_debug(health)

func damage(damage : float):
	print_debug("recebi", damage)
	health -= damage
	print_debug(health)
	pass
