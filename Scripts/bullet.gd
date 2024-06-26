extends Node2D

var speed = 25

func _process(delta):
	look_at(GLOBALS.player_pos)
	
	position += transform.x * speed * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Input.action_press("dead")
