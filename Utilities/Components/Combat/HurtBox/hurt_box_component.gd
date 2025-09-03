class_name HurtBoxComponent extends Area2D

@onready var attack_component : AttackComponent = $"../AttackComponent"

func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass

func AreaEntered( area : Area2D ) -> void:
	if area is HitBoxComponent:
		area.TakeDamage( attack_component.damage )
	pass
