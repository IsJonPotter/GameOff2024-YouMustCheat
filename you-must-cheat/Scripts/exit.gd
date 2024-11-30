extends StaticBody2D

@onready var gate = $Gate
@onready var collider = $CollisionShape2D


func open_gate():
	gate.visible = false
	collider.disabled = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
