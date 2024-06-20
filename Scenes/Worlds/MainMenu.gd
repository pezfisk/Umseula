extends Node2D

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Worlds/World1/Level1.tscn")

func _on_Quit_pressed():
	get_tree().quit()

