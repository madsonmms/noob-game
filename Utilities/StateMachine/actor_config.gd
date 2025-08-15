extends State
class_name Actor

#Change this when using the state machine
@onready var parent_node = find_parent(get_tree().get_parent())
@onready var actor = parent_node


var move_speed : float
var player : CharacterBody2D
var player_position : Vector2
var actor_position : Vector2

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
func _process(_delta: float):
	player_position = player.global_position
	actor_position = actor.global_position
