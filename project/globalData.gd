extends Node

var gameStarted = false
var ticketNum = 0
var ticketOccupied = false
var doughs = ["Roti", "Naan"]
var curries = ["Paneer", "Gobi", "Butter Chicken"]

var times = [225, 270, 315]
var helpText = "..."

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var canTakeOrder = false

var viewingTicket = null
var viewingTicketNode = null
var allTickets = []
var pendingTickets = []
var storage = [0,0,0,0,0,0,0]

var ladleMoving = true
var is_roti_dragging = false;
var is_bowl_dragging = false;

var score = 0
var totalScore = 0
var orderFinished = false

var currentScene = "order"
var ticketCount = 0

var rng: RandomNumberGenerator
var timer: Timer

var customerLoc = [0,0,0]
var orderScript: Node
var recentTicket = null

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	timer = Timer.new()
	timer.wait_time = rng.randi_range(1,2)
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	if (pendingTickets.size() < 3):
		makeNewTicket()
	timer.wait_time = rng.randi_range(25,40)
	timer.start()

func _process(delta: float) -> void:
	keepRunningFunction()
	
func keepRunningFunction() -> void:
	if (pendingTickets.size() > 0):
		canTakeOrder = true
	else:
		canTakeOrder = false
		
func removeTicket():
	pendingTickets.remove_at(0)
	
func makeNewTicket():
	
	orderScript = get_tree().get_root().get_node("MainScene/order")
	if orderScript:
		orderScript.spawnCustomer()
	else:
		print("orderScript null!")
	
	ticketNum += 1
	var ticketNumber = str(ticketNum)
	var randomNum = randi() %2
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
		"position": Vector2(1011, 318),
		"custType" : ""
	}
	
	allTickets.append(ticket_data)
	pendingTickets.append(ticket_data)
	
func isStorageFull():
	var foundSpot = false
	for i in range(globalData.storage.size()):
		if (globalData.storage[i] == 0):
			foundSpot = true
	if foundSpot == false:
		return true
	else:
		return false
