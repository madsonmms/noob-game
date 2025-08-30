class_name HitBoxComponent extends Area2D

@export var health_component : HealthComponent

func _ready() -> void:
	pass

func TakeDamage( damage: float ) -> void:
	health_component.damage(damage)
