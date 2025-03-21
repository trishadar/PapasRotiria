extends Node2D

var sceneToSpawn = preload("res://roti.tscn")

var spawn_count: int = 0

func _on_order_button_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")


func _on_roll_button_pressed() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")


func _on_cook_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")


func _on_curry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")


func _on_take_order_button_pressed() -> void:
	spawn_scene()
	
	
func spawn_scene():
	var instance = sceneToSpawn.instantiate()
	add_child(instance)
	instance.position = Vector2(100,400)
	
	#figure out how to spawn in only one ball of dough at a time (check how many rotis are in scene?)
	#figure out how to move roti from one scene to next
	#figure out how to connect order ticket to roti to verify if the final order attached to the ticket is correct
	
