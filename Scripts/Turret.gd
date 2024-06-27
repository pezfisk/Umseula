extends Node2D

var bullet = load("res://Scenes/OtherStuff/bullet.tscn")
var inZone = false

onready var timer = $Timer

func _process(delta):
	if inZone and timer.is_stopped():
		timer.start(1.5)
		shoot()

func _on_Detection_body_entered(body):
	if body.is_in_group("player"):
		inZone = true

func _on_Detection_body_exited(body):
	if inZone and body.is_in_group("player"):
		inZone = false

func shoot():
	var b = bullet.instance()
	add_child(b)
	b.global_position = self.position
