extends Node2D

# @onready var help = $help
@onready var orderButton = $orderButton
@onready var rollButton = $rollButton
@onready var cookButton = $cookButton
@onready var curryButton = $curryButton
@onready var takeOrderButton = $takeOrderButton
@onready var score = $score
@onready var scoreLabel = $score/scoreLabel
@onready var totalScoreLabel = $score/totalScoreLabel
@onready var sidebar = $sidebar

# @onready var customer = $customer
@onready var customer_scene: PackedScene = preload("res://customer.tscn")
var customer = null

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null

@onready var cam = get_node("/root/MainScene/Camera2D")
@onready var globalSidebar = get_node("/root/MainScene/sidebar")

var orderPos = Vector2(576, 323)
var rollPos = Vector2(1856, 323)
var cookPos = Vector2(3136, 323)
var curryPos = Vector2(4416, 323)

var instance = null
var ticketSpawned = false
var ticketDeleted = false
var customerSpawned = false

var curCustomer = null

	
func change_to_order() -> void:
	cam.position = orderPos

func change_to_roll() -> void:
	cam.position = rollPos

func change_to_cook() -> void:
	cam.position = cookPos

func change_to_curry() -> void:
	cam.position = curryPos

func _on_take_order_button_pressed() -> void:
	
	if (curCustomer != null):
		remove_child(curCustomer)
		print("removed customer")
		globalData.customerLoc[4] = 0
	
	if (globalData.canTakeOrder == true and reachedTicketLimit() == false):
		if (globalData.ticketOccupied == true):
			# sidebar.moveTicket()
			globalSidebar.moveTicket()
		# sidebar.initial_spawn_scene()
		globalSidebar.initial_spawn_scene()
		ticketSpawned = true
		ticketDeleted = false
		takeOrderButton.text = " "
		globalData.canTakeOrder = false	
		globalData.removeTicket()
		
func reachedTicketLimit():
	if (globalData.ticketCount >= 7):
		return true
	else:
		return false

func _on_ready() -> void:
	pass
		
func customerEnter():
	
	var stop = false
	for i in range(globalData.customerLoc.size()-1):
		if (globalData.customerLoc[i+1] == 0 and stop == false):
			await get_tree().create_timer(0.3).timeout
			customer.position.x -= 150
		else:
			stop = true
			globalData.customerLoc[i] = 1
			print("full spot: ", i+1)
	if (stop == false):
		stop = true
		globalData.customerLoc[4] = 1
		curCustomer = customer
				
				

	
func _process(delta):
	
	if (globalData.orderFinished == true):
		ticketSpawned = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		sidebar.remove_scene()
		ticketDeleted = true

	if globalData.canTakeOrder == true:
		takeOrderButton.text = "TAKE ORDER"
		
	else:
		takeOrderButton.text = " "
	
	if (globalData.orderFinished == true):
		# print("Score: " + str(globalData.score))
		scoreLabel.text = "Score: " + str(globalData.score)
		totalScoreLabel.text = "Total Score: " + str(globalData.totalScore)
		score.visible = true
	else:
		score.visible = false
		
func spawnCustomer():
	customer = customer_scene.instantiate()
	add_child(customer)
	customer.position.x = 800
	customer.position.y = 430
	var animationPlayer = get_node("customer/AnimationPlayer")
	var randomNum = randi() %2
	if randomNum == 0:
		animationPlayer.play("rithika")
	elif randomNum == 1:
		animationPlayer.play("kyle")
	customer.visible = true
	customerSpawned = true
	customerEnter()
	
	
func _on_score_exit_button_pressed() -> void:
	score.visible = false
	globalData.score = 0
	globalData.orderFinished = false
