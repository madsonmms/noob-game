class_name HitBoxComponent extends Area2D

@onready var health_component : HealthComponent = $"../HealthComponent"

signal took_damage

func TakeDamage( damage: float ) -> void:
	took_damage.emit()
	health_component.damage(damage)
