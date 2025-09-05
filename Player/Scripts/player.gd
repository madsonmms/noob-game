class_name Player1
extends CharacterBody2D

@export var animation_handler : AnimationHandler
@onready var sprite : Sprite2D = $Sprite2D

var attacking : bool = false
var weapon : Node = null

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.DOWN
var move_speed :float = 100.0

func _ready() -> void:
	
	pass

func get_direction() -> Vector2:
	var dir : = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	return dir.normalized()

func pickup_weapon(weapon_scene : PackedScene) -> void:
	weapon = weapon_scene.instantiate()
	add_child(weapon)

func UpdateDirection(new_dir : Vector2) -> void:
	if weapon:
		match new_dir:
			Vector2.DOWN:
				weapon.hurt_box.rotation_degrees = 180
				weapon.hurt_box.position.y = -8.0
			Vector2.UP:
				weapon.hurt_box.rotation_degrees = 0
			Vector2.LEFT:
				weapon.hurt_box.rotation_degrees = -90
			Vector2.RIGHT:
				weapon.hurt_box.rotation_degrees = 90
			Vector2.ZERO:
				weapon.hurt_box.rotation_degrees = 0
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("z_button") and weapon: # mapeia 'Z' no InputMap como "attack"
		attacking = true

func _physics_process(_delta: float) -> void:
	direction = get_direction()
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
		UpdateDirection(direction)
