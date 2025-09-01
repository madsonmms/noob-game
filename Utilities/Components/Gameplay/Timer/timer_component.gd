class_name TimerComponent
extends Node

@onready var timer: Timer = Timer.new()

func _ready():
	add_child(timer) # o timer passa a viver dentro do componente
	timer.one_shot = true

func start_timer(time: float, callback: Callable = Callable()):
	# desconecta callback anterior se existir
	if callback.is_valid():
		if timer.timeout.is_connected(callback):
			timer.timeout.disconnect(callback)
		timer.timeout.connect(callback, CONNECT_ONE_SHOT)

	timer.wait_time = time
	timer.start()

func stop_timer():
	timer.stop()

func is_running() -> bool:
	return timer.time_left > 0

signal timeout

func _on_timeout():
	emit_signal("timeout")
