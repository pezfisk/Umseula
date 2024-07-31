extends Node2D

func _ready():
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")

func _on_Left_pressed():
	Input.action_press("ui_left")
func _on_Left_released():
	Input.action_release("ui_left")

func _on_Right_pressed():
	Input.action_press("ui_right")
func _on_Right_released():
	Input.action_release("ui_right")

func _on_Up_pressed():
	Input.action_press("ui_up")
func _on_Up_released():
	Input.action_release("ui_up")

# warning-ignore:unused_argument
func _physics_process(delta):
	$Label.text = "FPS: " + str(Engine.get_frames_per_second()) + " MSPF: "+ str(1/Engine.get_frames_per_second())
