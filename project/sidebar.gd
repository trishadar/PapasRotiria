extends Node2D

@onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton

@onready var cam = get_node("/root/MainScene/Camera2D")
var orderPos = Vector2(576, 323)
var rollPos = Vector2(1856, 323)
var cookPos = Vector2(3136, 323)
var curryPos = Vector2(4416, 323)

func _on_order_button_pressed() -> void:
	cam.position = orderPos


func _on_roll_button_pressed() -> void:
	cam.position = rollPos

func _on_cook_button_pressed() -> void:
	cam.position = cookPos


func _on_curry_button_pressed() -> void:
	cam.position = curryPos

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
		
