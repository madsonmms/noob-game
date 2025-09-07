extends Node
class_name ActorsConfig

#Change this when using the state machine
var actor : CharacterBody2D
#var actors : Array[Node] = []
var player : Player1

var player_position : Vector2
var actor_position : Vector2

var targets : Array[Actor] = []

func _ready():
	player = get_tree().get_first_node_in_group("Players")
	actor = get_parent().get_parent()
	
	#future implementation of mutiple actors
	#for n in get_tree().get_nodes_in_group("Actors"):
		#if n is Actor:
			#actors.append(n as Actor)
	
func _process(_delta: float):
	player_position = player.global_position
	actor_position = actor.global_position

func chasing_handler(actor1, actor2):
	var chaser = actor1
	var chased = actor2
	
	if actor1 and actor2:
		chaser.direction = chaser.global_position - chased.global_position
		return chaser.direction

func check_distance():
	
	#var direction : Vector2
#
	#direction = chasing_handler(actor, player)
	
	#if direction and direction.length() <= 20 and actor.state_machine.has_state("attackstate"):
		#emit_signal("Transitioned", self, "AttackState")
	#if direction and direction.length() >= 50:
		#emit_signal("Transitioned", self, "WanderState")
	#if direction and direction.length() > 20 and direction.length() < 50:
		#emit_signal("Transitioned", self, "ChasingState")
		
	return true

#Pega o nome do sprite atual para poder fazer as outras funções
func _get_sprite_name(name : String) -> Sprite2D:
	
	if actor is not Player1:
		
		var sprites = actor.sprites
		
		if sprites:
			for s in sprites:
				if s.name == name:
					return s
		
	return null

func show_sprite(name: String):
	for s in actor.sprites:
		s.visible = s.name == name

#Seta a sprite para a direção correta durante todo o estado
func sprite_direction(name : String, direction : Vector2 = Vector2.LEFT ):
	
	if actor is not Player1:
		var sprite = _get_sprite_name(name)
		
		if direction.x < 0:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1
			
		return direction
	elif actor is Player1 and player.weapon:
		var sprite = _get_sprite_name(name)
		
		if direction.x < 0:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1
			
		return direction
