extends Node2D

# @onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton

var sceneToSpawn: PackedScene = preload("res://ticket.tscn")
var zIndex = 10

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
		globalData.remove_ticket(globalData.currentTicket)
		

func _on_ready() -> void:
	# help.text = globalData.helpText
	pass
	
func _process(delta):
	#if orderButton.is_hovered():
		#globalData.helpText = "**Order Station**"
		#help.text = globalData.helpText
	#elif rollButton.is_hovered():
		#globalData.helpText = "**Roll Station**"
		#help.text = globalData.helpText
	#elif cookButton.is_hovered():
		#globalData.helpText = "**Cook Station**"
		#help.text = globalData.helpText
	#elif curryButton.is_hovered():
		#globalData.helpText = "**Curry Station**"
		#help.text = globalData.helpText
	#else:
		#globalData.helpText = "..."
		#help.text = globalData.helpText
		
	if (globalData.pendingTickets.size() >= 1):
		takeOrderButton.text = "Take Order"
	else:
		takeOrderButton.text = " "
		
func spawn_scene():
	print("ticket spawned")
	var instance = globalData.pendingTickets[0]
	add_child(instance)
	
	instance.position = Vector2(1011, 318)
	instance.visible = true
	zIndex += 1
	instance.z_index = zIndex
	
