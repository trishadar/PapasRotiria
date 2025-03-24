extends Node2D

# @onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null

	
func change_to_order() -> void:
	get_tree().change_scene_to_file("res://order.tscn")

func change_to_roll() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")

func change_to_cook() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")

func change_to_curry() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")


func _on_take_order_button_pressed() -> void:
	if (globalData.pendingTickets.size() >= 1):
		# store currently viewing ticket if there is one
		if (viewingTicketNode != null):
			var randomX = randi() % 550 + 50
			viewingTicketNode.position.x = randomX
			viewingTicketNode.shrink_scene()
			viewingTicketNode.move_to_top()
			var index = int(globalData.viewingTicket["ticketNumber"]) -1
			globalData.allTickets[index]["positionX"] = viewingTicketNode.position.x
			globalData.allTickets[index]["positionY"] = viewingTicketNode.position.y
			globalData.allTickets[index]["scaleX"] = scale.x
			globalData.allTickets[index]["scaleY"] = scale.y
			globalData.allTickets[index]["sizeX"] = .35*220
			globalData.allTickets[index]["sizeY"] = .35*330
		else:
			print("viewingTicketNode is null")
		
		spawn_scene()
		
		

func _on_ready() -> void:
	var instance_data = globalData.viewingTicket
	if (instance_data != null):
		print("reload viewing ticket")
		var instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		viewingTicketNode = instance
		
	else:
		print("viewing ticket is null")
		
	if (globalData.storedTickets != null and globalData.storedTickets.size() > 0):
		for ticketData in globalData.storedTickets:
			var ticket_instance = ticket_scene.instantiate()
			add_child(ticket_instance)
			ticket_instance.set_up(ticketData)
	
func _process(delta):
		
	if (globalData.pendingTickets.size() >= 1):
		takeOrderButton.text = "Take Order"
	else:
		takeOrderButton.text = " "
		
func spawn_scene():
	print("ticket spawned")
	var instance_data = globalData.pendingTickets[0]
	
	var instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.viewingTicket = instance_data
	globalData.ticketOccupied = true
	globalData.remove_ticket(instance_data)
	
	if viewingTicketNode == null:
		print("viewing ticket node NULL inside spawn_scene()")
	
