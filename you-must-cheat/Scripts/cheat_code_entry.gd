extends Control

@onready var h_box_container = $MarginContainer/HBoxContainer
@onready var text_background = $"Label Container/Text Background"
@onready var label = $"Label Container/Text Background/Label"
@onready var text_timer = $TextTimer

@export var player: CharacterBody2D 
@export var move_code: Array[int] = [2, 1, 4, 1, 2, 1, 4, 1]

var entered_code: Array[int] = []
var code_length: int = 8
var code_position: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	entered_code.resize(code_length)
	text_background.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("code_up"):
		entered_code[code_position] = 1
		print(entered_code[code_position])
		code_position += 1
	elif Input.is_action_just_pressed("code_left"):
		entered_code[code_position] = 2
		print(entered_code[code_position])
		code_position += 1
	elif Input.is_action_just_pressed("code_down"):
		entered_code[code_position] = 3
		print(entered_code[code_position])
		code_position += 1
	elif Input.is_action_just_pressed("code_right"):
		entered_code[code_position] = 4
		print(entered_code[code_position])
		code_position += 1
	elif Input.is_action_just_pressed("reset"):
		entered_code = []
		entered_code.resize(code_length)
		code_position = 0
	
	if code_position == code_length:
		print(entered_code)
		unlock_movement(entered_code)
		entered_code = []
		entered_code.resize(code_length)
		code_position = 0

func display_message(message: String):
	print(message)
	label.text = "[center]%s[center]" % message
	text_background.visible = true
	text_timer.start()

func unlock_movement(code : Array):
	if code == move_code && !player.canMove:
		player.canMove = true
		display_message("The statue can now move!")

func _on_text_timer_timeout():
	text_background.visible = false
