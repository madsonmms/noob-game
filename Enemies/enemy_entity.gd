class_name Enemy
extends CharacterBody2D

@onready var sprites: Array[Node] = find_children("*", "Sprite2D", true, false) #Array com todos os sprites

@onready var animation_handler : AnimationHandler = $AnimationHandler
@onready var state_machine : StateMachine = $StateMachine

@onready var hurtbox: HurtBoxComponent = $HurtBoxComponent
@onready var health_component : HealthComponent = $HealthComponent

var components : Dictionary = {}
var handlers : Dictionary = {}

var direction : Vector2 = Vector2.DOWN
var last_direction : Vector2 = Vector2.DOWN

var attacking : bool = false
var dead = false
var hit = false

func _ready() -> void:
	for child in get_children():
		if child is Node and "Component" in child.name:
			register_component(child.name, child)
		elif child is Node and "Handler" in child.name:
			register_handlers(child.name, child)

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction
	_is_dead()

func _is_dead() -> void:
	if health_component and health_component.health <= 0:
		dead = true
		await state_machine.transition_to("DeathState")

func drop() -> void:
	print_debug("10 moedas")
	queue_free()


#Handlers Control
func register_handlers(name : String, hand : Node):
	handlers[name] = hand

func get_handler(name : String) -> Node:
	return handlers.get(name, null)

#Components Control
func register_component(name : String, comp : Node):
	components[name] = comp

func get_component(name : String) -> Node:
	return components.get(name, null)
