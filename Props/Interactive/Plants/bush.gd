class_name Bush extends Node

func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass

func TakeDamage( _damage : int ) -> void:
	queue_free()
	pass
