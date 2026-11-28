extends Control



func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Levels/Level1.tscn")
	pass # Replace with function body.


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_TutorialButton_pressed() -> void:
	get_tree().change_scene("res://Levels/TutorialLevel.tscn")
	pass # Replace with function body.
