extends StaticBody2D

enum States {locked, closed, open}

@onready var door_sheet = $"Door-sheet"
@onready var animation_player = $AnimationPlayer

@export var state: States = States.closed

func _ready():
	set_state(state)

func set_state(new_state: int):
	var old_state = state
	state = new_state
	
	match state:
		States.locked:
			door_sheet.frame = 0
		States.closed:
			if old_state == States.open:
				animation_player.play("close")
			else:
				door_sheet.frame = 1
		States.open:
			animation_player.play("open")


func _on_door_opening_spots_body_entered(body):
	if body.is_in_group("player") && state == States.closed:
		set_state(2)

func _on_door_opening_spots_body_exited(body):
	if body.is_in_group("player") && state == States.open:
		set_state(1)
