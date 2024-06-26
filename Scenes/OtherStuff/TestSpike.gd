extends Area2D

# warning-ignore:unused_argument
func _on_Spike_body_entered(body):
	
	if body.is_in_group("player"):
		$Particles2D.emitting = true
		Input.action_press("dead")
