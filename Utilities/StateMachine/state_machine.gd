class_name StateMachine extends Node

@export var initial_state : State
var current_state : State
var states : Dictionary = {}

@export var actor : CharacterBody2D

func _ready() -> void:
	
	for child in get_children():
		if child is State:
			child.actor = get_parent()
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
		initial_state.Enter()
		current_state = initial_state
		print_debug(current_state)
	
func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
