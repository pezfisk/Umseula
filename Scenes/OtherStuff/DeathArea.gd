extends Area2D

func _on_Area2D_body_entered(_body):
	Input.action_press("dead")
