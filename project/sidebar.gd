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

var instance = null
@onready var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var startingPos = position

func _on_order_button_pressed() -> void:
	cam.position = orderPos
	position = startingPos
	globalData.currentScene = "order"

func _on_roll_button_pressed() -> void:
	cam.position = rollPos
	position.x = startingPos.x + 1280
	globalData.currentScene = "roll"

func _on_cook_button_pressed() -> void:
	cam.position = cookPos
	position.x = startingPos.x + 1280 *2
	globalData.currentScene = "cook"

func _on_curry_button_pressed() -> void:
	cam.position = curryPos
	position.x = startingPos.x + 1280 *3
	globalData.currentScene = "curry"

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
		
func initial_spawn_scene():
	var instance_data = globalData.pendingTickets[0]
	instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.viewingTicket = instance_data
	globalData.ticketOccupied = true
	globalData.orderFinished = false
	globalData.ticketCount += 1
	
func remove_scene():
	if (globalData.orderFinished == true):
		print("order finished")
		if (viewingTicketNode != null):
			print("viewing ticket deleted")
			remove_child(viewingTicketNode)
			viewingTicketNode = null
		else:
			print("viewingTicketNode is null")
	
func moveTicket():
	viewingTicketNode.move_to_top()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
