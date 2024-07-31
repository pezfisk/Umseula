extends Node2D

func _on_Start_pressed():
# warning-ignore:return_value_discarded

	if DataParser.getData() != null:

		var dataStr = DataParser.loadData("WorldSave", "currentWorld")

		var loadedData = dataStr.split("-", true, 2)
		
		var loadedWorld = loadedData[0].split("_", true, 2)[1]
		var loadedLevel = loadedData[1].split("_", true, 2)[1]

		get_tree().change_scene("res://Scenes/Worlds/World" + str(loadedWorld) + "/Level" + str(loadedLevel) + ".tscn")
		
	else:
		
		get_tree().change_scene("res://Scenes/Worlds/World1/Level1.tscn")


func _on_Quit_pressed():
	get_tree().quit()

func _on_About_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://bento.me/inv")
