extends Node2D

# @onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton

var ticket_scene: PackedScene = preload("res://ticket.tscn")

var timer: Timer
var target_time: int

var currentTicket
	
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
		spawn_scene()
		globalData.ticketOccupied = true
		globalData.remove_ticket(globalData.pendingTickets[0])
		

func _on_ready() -> void:
	var instance_data = globalData.viewingTicket
	if (instance_data != null):
		print("reload viewing ticket")
		var instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		
	else:
		print("viewing ticket is null")
	
func _process(delta):
		
	if (globalData.pendingTickets.size() >= 1):
		takeOrderButton.text = "Take Order"
	else:
		takeOrderButton.text = " "
		
func spawn_scene():
	print("ticket spawned")
	var instance_data = globalData.pendingTickets[0]
	
	print(instance_data["ticketNumber"])
	print(instance_data["dough"])
	print(instance_data["curry"])
	print(instance_data["time"])
	
	var instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	globalData.viewingTicket = instance_data
	
