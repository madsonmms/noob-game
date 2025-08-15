class_name PlayerState extends State

var actor : Player1

func _ready():
	actor = get_parent().get_parent() as Player1
	pass

func get_input_direction() -> Vector2:
	var dir : = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return dir.normalized()
