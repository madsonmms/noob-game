class_name Actor
extends CharacterBody2D

@onready var state_machine = get_node("StateMachine")

func _ready() -> void:
	state_machine.set_actor(self)
