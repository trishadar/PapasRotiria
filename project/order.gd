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
var curCustomer = null

var customers = [null,null,null]

	
func change_to_order() -> void:
	cam.position = orderPos

func change_to_roll() -> void:
	cam.position = rollPos

func change_to_cook() -> void:
	cam.position = cookPos

func change_to_curry() -> void:
	cam.position = curryPos

func _on_take_order_button_pressed() -> void:
	
	curCustomer = customers[2]
	if (curCustomer != null):
		
		print("----------------------------")
		for i in range(globalData.customerLoc.size()):
			print(i , ": ", globalData.customerLoc[i])
		
		remove_child(curCustomer)
		print("removed customer")
		globalData.customerLoc[2] = 0
		customers[2] = null
		
		#shift all customers forward
		for i in range(customers.size()-1,0,-1):
			if (customers[i-1] != null):
				var cust = customers[i-1]
				customers[i] = cust
				customers[i-1] = null
				globalData.customerLoc[i] = 1
				globalData.customerLoc[i-1] = 0
				cust.position.x -= 150
					
		for i in range(globalData.customerLoc.size()):
			print(i , ": ", globalData.customerLoc[i])
	
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
	for i in range(-1, globalData.customerLoc.size()-1):
		if (globalData.customerLoc[i+1] == 0 and stop == false):
			await get_tree().create_timer(0.2).timeout
			customer.position.x -= 150
		else:
			print("got blocked")
			stop = true
			if (i >= 0):
				globalData.customerLoc[i] = 1
				customers[i] = customer
	if (stop == false):
		print("reached front")
		stop = true
		globalData.customerLoc[2] = 1
		customers[2] = customer
				
				

	
func _process(delta):
	
	curCustomer = customers[2]
	
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
	customer.position.x = 700
	customer.position.y = 430
	var animationPlayer = customer.get_node("AnimationPlayer")
	var randomNum = randi() %2
	if randomNum == 0:
		animationPlayer.play("rithika")
	elif randomNum == 1:
		animationPlayer.play("kyle")
	customer.visible = true
	customerEnter()
	
	
func _on_score_exit_button_pressed() -> void:
	score.visible = false
	globalData.score = 0
	globalData.orderFinished = false
