extends CharacterBody2D

const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0

@export var base_speed = 300.0
@export var canOpenDoor = false
@export var canPush = false

var SPEED = 0
var canMove = false

func _ready():
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	
	if (x_direction || y_direction) && canMove:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_block = collision.get_collider()
		
		if canPush && collision_block.is_in_group("Blocks"):
			var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
			collision_block.apply_central_impulse(collision.get_normal() * -push_force)
	
	move_and_slide()

func _on_timeline_started():
	canMove = false

func _on_timeline_ended():
	canMove = true
