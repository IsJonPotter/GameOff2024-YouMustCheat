extends Control

enum Codes {UP, LEFT, DOWN, RIGHT}

@onready var h_box_container = $"CodeContainer"/HBoxContainer
@onready var text_background = $"LabelContainer/Text Background"
@onready var label = $"LabelContainer/Text Background/Label"
@onready var text_timer = $TextTimer

# Scenes
@export var player: CharacterBody2D 
@export var exit: StaticBody2D

# Codes
@export var move_code: Array[Codes] = [Codes.LEFT, Codes.UP, Codes.RIGHT, Codes.UP, Codes.LEFT, Codes.UP, Codes.RIGHT, Codes.UP]
@export var door_code: Array[Codes] = [Codes.DOWN, Codes.LEFT, Codes.LEFT, Codes.UP, Codes.LEFT, Codes.UP, Codes.UP, Codes.RIGHT]
@export var push_code: Array[Codes] = [Codes.LEFT, Codes.DOWN, Codes.LEFT, Codes.RIGHT, Codes.RIGHT, Codes.DOWN, Codes.DOWN, Codes.RIGHT]
@export var exit_code: Array[Codes] = [Codes.RIGHT, Codes.LEFT, Codes.RIGHT, Codes.UP, Codes.RIGHT, Codes.LEFT, Codes.DOWN, Codes.DOWN]

var entered_code: Array[int] = []
var code_length: int = 8
var code_position: int = 0
var can_code: bool = false
var exit_open: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	entered_code.resize(code_length)
	text_background.visible = false
	
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if can_code:
		if Input.is_action_just_pressed("code_up"):
			entered_code[code_position] = Codes.UP
			print(entered_code[code_position])
			code_position += 1
		elif Input.is_action_just_pressed("code_left"):
			entered_code[code_position] = Codes.LEFT
			print(entered_code[code_position])
			code_position += 1
		elif Input.is_action_just_pressed("code_down"):
			entered_code[code_position] = Codes.DOWN
			print(entered_code[code_position])
			code_position += 1
		elif Input.is_action_just_pressed("code_right"):
			entered_code[code_position] = Codes.RIGHT
			print(entered_code[code_position])
			code_position += 1
		elif Input.is_action_just_pressed("reset"):
			entered_code = []
			entered_code.resize(code_length)
			code_position = 0
			display_message("Code Reset")
	
	if code_position == code_length:
		print(entered_code)
		
		if entered_code == move_code:
			unlock_movement()
		elif entered_code == door_code:
			unlock_door_open()
		elif entered_code == push_code:
			unlock_push_block()
		elif entered_code == exit_code:
			unlock_exit()
		else:
			display_message("Invalid code")
		
		entered_code = []
		entered_code.resize(code_length)
		code_position = 0

func display_message(message: String):
	print(message)
	label.text = "[center]%s[center]" % message
	text_background.visible = true
	text_timer.start()

func unlock_movement():
	if player.SPEED != player.base_speed:
		player.SPEED = player.base_speed
		display_message("The statue can now move!")
	else:
		display_message("Code already used")

func unlock_door_open():
	if !player.canOpenDoor:
		player.canOpenDoor = true
		display_message("The statue can now open doors!")
	else:
		display_message("Code already used")

func unlock_push_block():
	if !player.canPush:
		player.canPush = true
		display_message("The statue can now push objects!")
	else:
		display_message("Code already used")

func unlock_exit():
	if !exit_open:
		exit.open_gate()
		display_message("The exit has been opened!")
	else:
		display_message("Code already used")

func _on_text_timer_timeout():
	text_background.visible = false

func _on_timeline_started():
	can_code = false

func _on_timeline_ended():
	can_code = true
