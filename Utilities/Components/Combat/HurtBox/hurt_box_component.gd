class_name HurtBoxComponent extends Area2D

@export var attack_component : AttackComponent
@export var weapon : Sword


func _ready() -> void:
	if weapon || attack_component:
		area_entered.connect( AreaEntered )
	pass

func AreaEntered( area : Area2D ) -> void:
	if area is HitBoxComponent and weapon:
		area.TakeDamage( weapon.damage )
	elif area is HitBoxComponent:
		area.TakeDamage( attack_component.damage )
