extends Node

var gameStarted = false
var ticketNum = 0
var ticketOccupied = false
var doughs = ["Regular", "Naan", "Paratha"]
var curries = ["Paneer", "Gobi", "Butter Chicken"]
var times = ["20 Seconds", "40 Seconds", "60 Seconds"]
var helpText = "..."
var canTakeOrder = true

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var pendingTickets: Array = []
var allTickets: Array = []
var currentTicket
var storedTickets: Array = []

var viewingTicket = null

var timer: Timer
var target_time: int

func _ready() -> void:
	if (gameStarted == true):
		# add_ticket()
		var firstTimerStarted = false
		
		# create timer
		timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		add_child(timer)
		
		# start first timer
		start_new_timer()
		firstTimerStarted = true
		
func add_ticket(ticket_instance_data) -> void:
	# Add the instance to the array
	pendingTickets.append(ticket_instance_data)
	allTickets.append(ticket_instance_data)

func remove_ticket(ticket_data: Dictionary) -> void:
	# Remove the enemy from the array and the scene tree
	if pendingTickets.has(ticket_data):
		pendingTickets.erase(ticket_data)
		# ticket.queue_free()  # Free the node

func _process(delta: float) -> void:
	keepRunningFunction()
	
func keepRunningFunction() -> void:
	if (gameStarted == true):
		var firstTimerStarted = false
		
		# create timer
		timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		add_child(timer)
		
		# start first timer
		start_new_timer()
		firstTimerStarted = true
		gameStarted = false
	
func start_new_timer() -> void:
	# generate random target time between 15 and 60 seconds
	target_time = randi() % 5 + 5
	timer.start(target_time)
	print("timer started: ", target_time)
	
func _on_Timer_timeout() -> void:
	canTakeOrder = true
	print("timer ended")
	ticketNum += 1
	var ticketNumber = str(ticketNum)
	var randomNum = randi() %3
	var dough = str(doughs[randomNum])
	randomNum = randi() %3
	var curry = str(curries[randomNum])
	randomNum = randi() %3
	var time = str(times[randomNum])
	
	var ticket_data = {
		"ticketNumber": ticketNumber,
		"dough": dough,
		"curry": curry,
		"time": time,
		"positionX": 1011,
		"positionY": 318,
		"scaleX": 1,
		"scaleY": 1, 
		"sizeX": 220,
		"sizeY": 330
		
	}
	
	currentTicket = ticket_data
	add_ticket(ticket_data)
	start_new_timer()
	
