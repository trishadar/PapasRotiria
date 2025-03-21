extends Node2D

@onready var ticket = $ticket
@onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton
@onready var sideBox = $sideBox

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
	takeOrderButton.text = " "

func _on_ready() -> void:
	help.text = globalData.helpText
	takeOrderButton.text = "Take Order"
	
func _process(delta):
	if orderButton.is_hovered():
		globalData.helpText = "**Order Station**"
		help.text = globalData.helpText
	elif rollButton.is_hovered():
		globalData.helpText = "**Roll Station**"
		help.text = globalData.helpText
	elif cookButton.is_hovered():
		globalData.helpText = "**Cook Station**"
		help.text = globalData.helpText
	elif curryButton.is_hovered():
		globalData.helpText = "**Curry Station**"
		help.text = globalData.helpText
	else:
		globalData.helpText = "..."
		help.text = globalData.helpText
