extends Node2D

@export var cheat_code_entry : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("intro_timeline")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		Dialogic.end_timeline()
