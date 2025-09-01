class_name Enemy
extends CharacterBody2D

@onready var sprites: Array[Node] = find_children("*", "Sprite2D", true, false) #Array com todos os sprites
@onready var health_component : HealthComponent = $HealthComponent
@onready var animation_handler : AnimationHandler = $AnimationHandler
@onready var state_machine : StateMachine = $StateMachine
@onready var hurt_box: HurtBoxComponent = $HurtBoxComponent

var attacking : bool = false
var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN
var dead = false

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction
	_is_dead()

func _is_dead() -> void:
	if health_component and health_component.health <= 0:
		dead = true
		await state_machine.transition_to("DeathState")

func drop() -> void:
	queue_free()
