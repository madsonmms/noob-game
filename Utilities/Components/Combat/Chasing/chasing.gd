extends Node2D
class_name ChasingComponent

@export var chasing_speed : float = 1.0
@export var always_follow_target : bool = false
@export var target_path : NodePath #Para pets

var pursuer : Node = null
var target : Node = null
var detection_area : Area2D

func _ready():
	pursuer = get_parent()
	detection_area = $DetectionArea if has_node("DetectionArea") else null
	
	#Para pets ou coisas assim
	if always_follow_target and target_path != NodePath():
		target = get_node(target_path)
		
func _process(delta):
	if detection_area:
		if detection_area.area_entered.is_connected(_on_area_entered):
			detection_area.area_entered.disconnect(_on_area_entered)
			detection_area.area_entered.connect(_on_area_entered)	
		
		if detection_area.area_exited.is_connected(_on_area_exited):
			detection_area.area_entered.disconnect(_on_area_entered)
			detection_area.area_exited.connect(_on_area_exited)
		
		
	if target and pursuer:
		var direction = (target.global_position - pursuer.global_position).normalized()
		if "velocity" in pursuer:
			pursuer.velocity = direction * chasing_speed
			
func _on_area_entered(area: Area2D) -> void:
	print_debug("on area entered")
	if area.is_in_group("Players"):
		target = area
		
		
func _on_area_exited(area: Area2D) -> void:
	if target == area and not always_follow_target:
		target == null
