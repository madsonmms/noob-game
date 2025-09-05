class_name Sword extends Node2D

@export var damage : float = 1.0
@export var knockback : bool = false
@export var knockback_force : float = 10.0

@onready var hurt_box : HurtBoxComponent = $HurtBoxComponent
