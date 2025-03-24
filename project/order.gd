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
	spawn_scene()
	takeOrderButton.text = " "
	globalData.canTakeOrder = false	
		
		

func _on_ready() -> void:
	if globalData.canTakeOrder == true:
		takeOrderButton.text = "TAKE ORDER"
	else:
		takeOrderButton.text = " "
		
	if (globalData.viewingTicket != null):
		var instance_data = globalData.viewingTicket
		var instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		viewingTicketNode = instance
		globalData.viewingTicket = instance_data
		globalData.ticketOccupied = true
	
	
func _process(delta):
	pass
		
func spawn_scene():
	print("ticket spawned")
	var instance_data = globalData.allTickets[0]
	var instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.viewingTicket = instance_data
	globalData.ticketOccupied = true
	
	
	
