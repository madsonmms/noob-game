extends Node2D
class_name ChasingComponent

@export var chasing_speed : float = 1.0
@export var always_follow_target : bool = false
@export var target_path : NodePath #Para pets

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D
@onready var timer : Timer = $Timer

var pursuer : Node = null
var target : Node = null
var detection_area : Area2D
var direction = null

func _ready():
	make_path()
	pursuer = get_parent()
	detection_area = $DetectionArea if has_node("DetectionArea") else null
	
	#Para pets ou coisas assim
	if always_follow_target and target_path != NodePath():
		target = get_node(target_path)

func _process(_delta : float):
	
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	
	if detection_area:
		
		if detection_area.area_entered.is_connected(_on_area_entered):
			detection_area.area_entered.disconnect(_on_area_entered)
		detection_area.area_entered.connect(_on_area_entered)
		
		if detection_area.area_exited.is_connected(_on_area_entered):
			detection_area.area_exited.disconnect(_on_area_entered)
			detection_area.area_exited.connect(_on_area_exited)
		
	if target and pursuer:
		pursuer.velocity = direction * pursuer.move_speed * chasing_speed
		pursuer.move_and_slide()
		

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Players") || direction:
		target = area

func _on_area_exited(area: Area2D) -> void:
	if target == area and not always_follow_target:
		target == null

func make_path() -> void:
	if target:
		nav_agent.target_position = target.global_position
		print_debug(nav_agent.target_position)

func _on_timer_timeout() -> void:
	make_path()
