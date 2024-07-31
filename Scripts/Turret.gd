extends Node2D

var bullet = load("res://Scenes/OtherStuff/bullet.tscn")
var inZone = false

onready var timer = $Timer

func _on_Detection_body_entered(body):
	if body.is_in_group("player"):
		inZone = true
		if timer.is_stopped():
			shoot()

func _on_Detection_body_exited(body):
	if inZone and body.is_in_group("player"):
		inZone = false

func shoot():
	var b = bullet.instance()
	add_child(b)
	b.global_position = self.global_position
	timer.start(2)

func _on_Timer_timeout():
	if inZone:
		shoot()
