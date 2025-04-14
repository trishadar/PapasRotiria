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
var ticketDeleted = false
var ticketSpawned = false

func _on_order_button_pressed() -> void:
	cam.position = orderPos
	globalData.currentScene = "order"

func _on_roll_button_pressed() -> void:
	cam.position = rollPos
	globalData.currentScene = "roll"

func _on_cook_button_pressed() -> void:
	cam.position = cookPos
	globalData.currentScene = "cook"

func _on_curry_button_pressed() -> void:
	cam.position = curryPos
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
	var instance_data = globalData.allTickets[-1]
	instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.viewingTicket = instance_data
	globalData.ticketOccupied = true
	globalData.orderFinished = false
	ticketDeleted = false
	ticketSpawned = true
	
func spawn_scene():
	var instance_data = globalData.viewingTicket
	# print("ticket position: ", instance_data["position"])
	instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.ticketOccupied = true
	globalData.orderFinished = false
	ticketDeleted = false
	ticketSpawned = true
	
func remove_scene():
	if (globalData.orderFinished == true and ticketDeleted == false):
		if (instance != null):
			instance.queue_free()
			ticketDeleted = true
		
func update_ticket():
	instance.set_up(globalData.viewingTicket)
