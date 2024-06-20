extends Node

export(String, FILE) var next_world

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	if Input.is_action_just_pressed("NextLevel"):
		get_tree().change_scene(next_world)

func _process(delta):
	$Sprite.rotation += 1 * delta

# warning-ignore:unused_argument
func _on_NextLevel_body_entered(body):
	$Timer.start()
	Input.action_press("NextLevelChangeSkin")

func _on_Timer_timeout():
	Input.action_press("NextLevel")
