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
		
func add_ticket(ticket_instance) -> void:
	# Add the instance to the array
	pendingTickets.append(ticket_instance)
	allTickets.append(ticket_instance)

func remove_ticket(ticket: Node) -> void:
	# Remove the enemy from the array and the scene tree
	if pendingTickets.has(ticket):
		pendingTickets.erase(ticket)
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
	globalData.canTakeOrder = true
	print("timer ended")
	globalData.ticketNum += 1
	var instance = ticket_scene.instantiate()
	currentTicket = instance
	add_child(instance)
	instance.position = Vector2(1011, 318)
	instance.visible = true
	add_ticket(instance)
	start_new_timer()
