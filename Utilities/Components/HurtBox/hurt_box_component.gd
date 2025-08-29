class_name HurtBoxComponent extends Area2D

@export var damage : int = 2

func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass

func AreaEntered( area : Area2D ) -> void:
	if area is HitBoxComponent:
		area.TakeDamage( damage )
	pass
	
