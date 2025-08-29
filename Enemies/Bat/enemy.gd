class_name Enemy
extends CharacterBody2D

@export var animation_handler : AnimationHandler
@export var state_machine : StateMachine

@onready var sprite : Sprite2D = $Sprite2D
@onready var health_component : HealthComponent = $HealthComponent

var attacking : bool = false
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN

var move_speed : int = 20

signal DirectionChanged( new_dir : Vector2 )

func get_direction() -> Vector2:
	var dir = direction
	return dir.normalized()
	

func _physics_process(_delta: float) -> void:
	direction = get_direction()
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
		DirectionChanged.emit( last_direction )
	else:
		last_direction = Vector2.LEFT
		
	if health_component.health <= 0: 
		queue_free()
