extends State
class_name Actor

#Change this when using the state machine
var actor : CharacterBody2D
var player : CharacterBody2D
var player_position : Vector2
var actor_position : Vector2

func _ready():
	player = get_tree().get_first_node_in_group("Players")
	actor = get_parent().get_parent()
	
func _process(_delta: float):
	player_position = player.global_position
	actor_position = actor.global_position
