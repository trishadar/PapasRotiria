extends Node

var gameStarted = false
var ticketNum = 0
var ticketOccupied = false
var doughs = ["Regular", "Naan", "Paratha"]
var curries = ["Paneer", "Gobi", "Butter Chicken"]
var times = ["20 Seconds", "40 Seconds", "60 Seconds"]
var helpText = "..."

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var canTakeOrder = true

var viewingTicket = null
var allTickets = []

var ladleMoving = true
var is_dragging = false;

var score = 0
var totalScore = 0
var orderFinished = false


func _ready() -> void:
	makeNewTicket()

func _process(delta: float) -> void:
	keepRunningFunction()
	
func keepRunningFunction() -> void:
	pass
	
func makeNewTicket():
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
		"time": time
	}
	
	allTickets.append(ticket_data)
