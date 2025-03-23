extends Node2D

@onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton
@onready var sideBox = $sideBox
var sceneToSpawn: PackedScene = preload("res://ticket.tscn")
var zIndex = 10

var timer: Timer
var target_time: int
var firstTicketSpawned = false

var currentTicket

func _on_order_button_pressed() -> void:
	get_tree().change_scene_to_file("res://order.tscn")


func _on_roll_button_pressed() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")


func _on_cook_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")


func _on_curry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")


func _on_take_order_button_pressed() -> void:
	if (globalData.canTakeOrder == true):
		spawn_scene()
		globalData.ticketOccupied = true
		# takeOrderButton.text = " "
		globalData.canTakeOrder = false
		globalData.remove_ticket(currentTicket)
		firstTicketSpawned = true
		

func _on_ready() -> void:
	help.text = globalData.helpText
	takeOrderButton.text = "Take Order"
	
	# create timer
	#timer = Timer.new()
	#timer.one_shot = true
	#timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	#add_child(timer)
	
#func start_new_timer() -> void:
	# generate random target time between 15 and 60 seconds
	#target_time = randi() % 5 + 5
	#timer.start(target_time)
	#print("timer started: ", target_time)
	
#func _on_Timer_timeout() -> void:
	#globalData.canTakeOrder = true
	#print("timer ended")
	#takeOrderButton.text = "Take Order"
	#start_new_timer()
	
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
		
	if firstTicketSpawned == true:
		if (globalData.pendingTickets.size() >= 1):
			takeOrderButton.text = "Take Order"
		else:
			takeOrderButton.text = " "
		
func spawn_scene():
	if sceneToSpawn:
		print("ticket spawned")
		globalData.ticketNum += 1
		var instance = sceneToSpawn.instantiate()
		currentTicket = instance
		add_child(instance)
		instance.position = Vector2(1011, 318)
		instance.visible = true
		zIndex += 1
		instance.z_index = zIndex
		globalData.ticketOccupied
		globalData.add_ticket(instance)
