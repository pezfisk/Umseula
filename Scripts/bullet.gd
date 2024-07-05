extends Node2D

var speed = 30
var stopLook : bool = true
var startAnim : bool = true

func _process(delta):
	if not stopLook:
		look_at(GLOBALS.player_pos)
		
	if startAnim:
		position.y -= delta * 20
		self.global_rotation_degrees = -90
	else:
		position += transform.x * speed * delta
		speed += 0.01

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Input.action_press("dead")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_rotTimer_timeout():
	stopLook = true

func _on_startTimer_timeout():
	stopLook = false
	startAnim = false
