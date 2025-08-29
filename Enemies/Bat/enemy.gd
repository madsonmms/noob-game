class_name Enemy
extends CharacterBody2D

@export var animation_handler : AnimationHandler

@onready var sprite : Sprite2D = $Sprite2D
@onready var health_component : HealthComponent = $HealthComponent

var attacking : bool = false
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN

@export var move_speed : int = 20

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction
	
	if health_component.health <= 0: 
		queue_free()
