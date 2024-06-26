extends Node2D

var bullet = load("res://Scenes/OtherStuff/bullet.tscn")

func _on_Detection_body_entered(body):
	if body.is_in_group("player"):
		var b = bullet.instance()
		add_child(b)
		b.global_position = self.position
