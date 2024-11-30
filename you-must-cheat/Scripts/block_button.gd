extends Area2D

@onready var hole_sprite = $Sprite2D
@onready var block_drop = $"Block Drop"

@export var door: StaticBody2D

var hole_full: bool = false

func _on_body_entered(body):
	if body.is_in_group("Blocks"):
		hole_full = true
		hole_sprite.frame = 1
		body.destroy_block()
		door.unlock(true)
		block_drop.play()
