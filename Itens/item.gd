extends Area2D
class_name Item

@export var weapon_scene : PackedScene
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Players"):
		if weapon_scene:
			body.pickup_weapon(weapon_scene)
		queue_free()
