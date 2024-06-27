extends Node2D

var speed = 30
var stopLook : bool = false

func _process(delta):
	if not stopLook:
		look_at(GLOBALS.player_pos)
	
	position += transform.x * speed * delta
	speed += 0.01

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Input.action_press("dead")
		queue_free()


func _on_Timer_timeout():
	stopLook = true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
