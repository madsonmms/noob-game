class_name Player1
extends CharacterBody2D

@export var stats : Stats
@export var animation_handler : AnimationHandler
@export var state_machine : StateMachine
@onready var sprite : Sprite2D = $Sprite2D

var attacking : bool = false
var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.DOWN

func get_input_direction() -> Vector2:
	var dir : = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return dir.normalized()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("z_button"): # mapeia 'Z' no InputMap como "attack"
		attacking = true

func _physics_process(_delta: float) -> void:
	direction = get_input_direction()
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
