extends RigidBody2D

var original_position: Vector2
var reset_position: bool = false

func _ready():
	original_position = position
	Dialogic.signal_event.connect(_on_dialogic_signal)

func destroy_block():
	queue_free()

func _on_dialogic_signal(argument: String):
	if argument == "reset_block":
		reset_position = true

func _integrate_forces(state):
	if reset_position:
		state.transform.origin = original_position
		reset_position = false
