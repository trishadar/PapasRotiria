extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
