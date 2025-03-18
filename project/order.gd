extends Node2D



func _on_order_button_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")


func _on_roll_button_pressed() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")


func _on_cook_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")


func _on_curry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")
