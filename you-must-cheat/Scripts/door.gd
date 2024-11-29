extends StaticBody2D

enum States {LOCKED, CLOSED, OPEN}

@onready var door_sheet = $"Door-sheet"
@onready var animation_player = $AnimationPlayer

@export var state: States = States.CLOSED

func _ready():
	set_state(state)

func set_state(new_state: int):
	var old_state = state
	state = new_state
	
	match state:
		States.LOCKED:
			door_sheet.frame = 0
		States.CLOSED:
			if old_state == States.OPEN:
				animation_player.play("close")
			else:
				door_sheet.frame = 1
		States.OPEN:
			animation_player.play("open")

func unlock(activate: bool):
	set_state(1)

func _on_door_opening_spots_body_entered(body):
	if body.is_in_group("player") && body.canOpenDoor && state == States.CLOSED:
		set_state(2)

func _on_door_opening_spots_body_exited(body):
	if body.is_in_group("player") && state == States.OPEN:
		set_state(1)
