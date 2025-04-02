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

@onready var customer = $customer
@onready var animationPlayer = $customer/AnimationPlayer

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null

@onready var cam = get_node("/root/MainScene/Camera2D")
var orderPos = Vector2(576, 323)
var rollPos = Vector2(1856, 323)
var cookPos = Vector2(3136, 323)
var curryPos = Vector2(4416, 323)
var customerWalked = false

	
func change_to_order() -> void:
	cam.position = orderPos

func change_to_roll() -> void:
	cam.position = rollPos

func change_to_cook() -> void:
	cam.position = cookPos

func change_to_curry() -> void:
	cam.position = curryPos


func customerWalk():
	customer.position.x -= 200
	customerWalked = true

func _on_take_order_button_pressed() -> void:
	if (globalData.canTakeOrder == true):
		spawn_scene()
		takeOrderButton.text = " "
		customer.visible = false
		globalData.canTakeOrder = false	
		
		

func _on_ready() -> void:
	pass
		
	
	
func _process(delta):
	if globalData.canTakeOrder == true:
		takeOrderButton.text = "TAKE ORDER"
		
		if customerWalked == false:
			animationPlayer.play("lewatson")
			customerWalk()
			customer.visible = true
	else:
		takeOrderButton.text = " "
		customer.visible = false
	
	if (globalData.orderFinished == true):
		# print("Score: " + str(globalData.score))
		scoreLabel.text = "Score: " + str(globalData.score)
		totalScoreLabel.text = "Total Score: " + str(globalData.totalScore)
		score.visible = true
	else:
		score.visible = false
		
func spawn_scene():
	print("ticket spawned")
	var instance_data = globalData.allTickets[-1]
	var instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(instance_data)
	viewingTicketNode = instance
	globalData.viewingTicket = instance_data
	globalData.ticketOccupied = true
	
	
func _on_score_exit_button_pressed() -> void:
	score.visible = false
	globalData.score = 0
	globalData.orderFinished = false
