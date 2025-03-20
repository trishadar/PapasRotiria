extends Node2D

@onready var ticket = $ticket
@onready var help = $help

func _on_order_button_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")


func _on_roll_button_pressed() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")


func _on_cook_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")


func _on_curry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")


func _on_take_order_button_pressed() -> void:
	ticket.visible = true
	globalData.ticketOccupied = true


func _on_ready() -> void:
	help.text = globalData.helpText
