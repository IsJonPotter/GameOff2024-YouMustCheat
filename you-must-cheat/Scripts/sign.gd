extends StaticBody2D

@onready var detect_interaction = $InteractionCircle/CollisionShape2D
@onready var color_rect = $ColorRect
@onready var dialogue_timer = $DialogueTimer

@export var dialog_name: String

var can_read: bool = false
var disable_interact: bool = true

func ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("dialogic_default_action") && can_read:
		Dialogic.start(dialog_name)
		disable_interact = true
		can_read = false
		color_rect.visible = false

func _on_interaction_circle_body_entered(body):
	if body.is_in_group("player"):
		can_read = true
		color_rect.visible = true
		disable_interact = false

func _on_interaction_circle_body_exited(body):
	if body.is_in_group("player"):
		can_read = false
		color_rect.visible = false
		disable_interact = true

func _on_timeline_ended():
	disable_interact = false
	dialogue_timer.start()

func _on_dialogue_timer_timeout():
	if !disable_interact:
		can_read = true
		color_rect.visible = true
