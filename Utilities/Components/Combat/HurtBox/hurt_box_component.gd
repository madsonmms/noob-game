class_name HurtBoxComponent extends Area2D

#@onready var attack_component : AttackComponent = $"../AttackComponent"
@onready var weapon : Sword = get_parent()


func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass

func AreaEntered( area : Area2D ) -> void:
	if area is HitBoxComponent:
		area.TakeDamage( weapon.damage )
	pass
