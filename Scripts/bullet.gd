extends Node2D

var speed = 30
var stopLook : bool = true
var startAnim : bool = true

onready var part = $Particles2D

func _physics_process(delta):
	var direction = (GLOBALS.player_pos - global_position).normalized()
	if not stopLook:
		look_at(GLOBALS.player_pos)
		
	if startAnim:
		position.y -= delta * 60
		self.global_rotation_degrees = -90
	else:
		position += transform.x * speed * delta
		if speed < 300:
			speed += 1
	
	$Sprite.rotation = $Sprite.rotation + 0.1 * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Input.action_press("dead")
		$Sprite.hide()
		$Particles2D2.hide()
		part.emitting = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_rotTimer_timeout():
	stopLook = true

func _on_startTimer_timeout():
	stopLook = false
	startAnim = false
