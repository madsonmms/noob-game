extends State
class_name ActorsConfig

#Change this when using the state machine
var actor : CharacterBody2D
var player : CharacterBody2D
var player_position : Vector2
var actor_position : Vector2

func _ready():
	#Take player and actor
	#if they are the same, try to use player reference for readability
	player = get_tree().get_first_node_in_group("Players")
	actor = get_parent().get_parent()
	
func _process(_delta: float):
	#Takes both, player and actor position to create interactions
	player_position = player.global_position
	actor_position = actor.global_position

#Handle the position between actors
#Can handle relation between player-actor or actor-actor
func chasing_handler(actor1, actor2):
	var chaser = actor1
	var chased = actor2
	
	if actor1 and actor2:
		chaser.direction = chaser.global_position - chased.global_position
		return chaser.direction

#Check the distance between actors
#For now it just check between actor-player, I'll change this in the future
func check_distance():
	var direction = chasing_handler(actor, player)
	
	#For now, my actors are just enemies, may change this part later
	if direction and direction.length() <= 20 and actor.state_machine.has_state("attackstate"):
		emit_signal("Transitioned", self, "AttackState")
	if direction and direction.length() >= 50:
		emit_signal("Transitioned", self, "WanderState")
	if direction and direction.length() > 20 and direction.length() < 50:
		emit_signal("Transitioned", self, "ChasingState")
		
	return true

#Take the actual sprite name
#Use this if your sprites are divided in diferent nodes
func _get_sprite_name(name : String) -> Sprite2D:
	
	var sprites = actor.sprites
	
	if sprites:
		for s in sprites:
			if s.name == name:
				return s
		
	return null

#Control the sprites visibility
#Use this if your sprites are divided in diferent nodes
func show_sprite(name: String):
	for s in actor.sprites:
		s.visible = s.name == name

#Keep the sprite direction correct
#If the actor change it's direction, keep the sprite to the right side
func sprite_direction(name : String, direction : Vector2 = Vector2.LEFT ):
	
	var sprite = _get_sprite_name(name)
	
	if direction.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
		
	return direction
