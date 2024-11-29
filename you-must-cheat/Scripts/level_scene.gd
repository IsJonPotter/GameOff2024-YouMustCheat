extends Node2D

@export var cheat_code_entry : Control

var game_started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Dialogic.start("intro_timeline")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		Dialogic.end_timeline()
		cheat_code_entry.can_code = true

func _on_dialogic_signal(argument: String):
	if argument == "Start":
		game_started = true
