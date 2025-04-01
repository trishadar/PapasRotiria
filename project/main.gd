extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
	globalData.gameStarted = true


func _on_quit_pressed() -> void:
	get_tree().quit()
