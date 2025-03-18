extends Node2D


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")  # Replace with function body.


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")
