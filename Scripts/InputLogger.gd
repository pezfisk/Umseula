extends Node

var input = []

var debug = ["left","left","left","left","up"]
var disableDebug = ["right","right","right","right","up"]

func _physics_process(delta):
	
	if input.size() > 5:
		input.remove(0)
	
	if Input.is_action_just_pressed("ui_left"):
		input.append("left")
	if Input.is_action_just_pressed("ui_right"):
		input.append("right")
	if Input.is_action_just_pressed("ui_up"):
		input.append("up")
	
	if input == debug:
		Input.action_press("debug")
	
	if input == disableDebug:
		Input.action_press("dissableDebug")
	
	
	print(input)



func _on_Timer_timeout():
	input.remove(0)
