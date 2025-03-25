extends Node2D

@onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton

func _on_order_button_pressed() -> void:
	var main_scene = get_parent()
	main_scene.change_to_order()


func _on_roll_button_pressed() -> void:
	var main_scene = get_parent()
	main_scene.change_to_roll()


func _on_cook_button_pressed() -> void:
	var main_scene = get_parent()
	main_scene.change_to_cook()


func _on_curry_button_pressed() -> void:
	var main_scene = get_parent()
	main_scene.change_to_curry()

func _on_ready() -> void:
	help.text = globalData.helpText
	
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
		
