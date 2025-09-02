class_name StateMachine
extends Node

@onready var actor : CharacterBody2D = get_parent()

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	
	print_debug(actor)
	
	for child in get_children():
		if child is State:
			child.actor = get_parent()
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
		initial_state.Enter()
		current_state = initial_state
	
func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
func transition_to(target_state_name: String):
	var target_state: State = get_node(target_state_name)
	
	current_state.Exit()
	current_state = target_state
	current_state.Enter()

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

func has_state(name: String) -> bool:
	return states.has(name)
