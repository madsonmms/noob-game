class_name HealthComponent
extends Node

@export var MAX_HEALTH : float = 3

@export var hit_box_component : HitBoxComponent

var health : float

func _ready() -> void:
	health = MAX_HEALTH

func damage(damage_taken : float):
	health -= damage_taken
	pass
