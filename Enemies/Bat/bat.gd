class_name Enemy
extends CharacterBody2D

@onready var sprite : Sprite2D = $Idle
@onready var health_component : HealthComponent = $HealthComponent
@onready var animation_handler : AnimationHandler = $AnimationHandler
@onready var state_machine : StateMachine = $StateMachine
@export var hurt_box: HurtBoxComponent

var attacking : bool = false
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN

@export var move_speed : float = 20

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction
		
	if direction == Vector2.RIGHT:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	if health_component.health <= 0: 
		queue_free()
