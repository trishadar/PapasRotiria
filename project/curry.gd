extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var is_colliding_green: bool = false
var is_colliding_yellow: bool = false
var is_colliding_red: bool = false
var curryFalling = true
var targetCurryY = 210
@onready var animationPlayer = $fallingCurry/AnimationPlayer
@onready var fallingCurry = $fallingCurry
@onready var ladle = $ladle
var currySelected = false
var spacePressed = false
var curryChosen
var ticketSpawned = false

@onready var cam = get_node("/root/MainScene/Camera2D")
var orderPos = Vector2(576, 323)

func change_to_order() -> void:
	get_tree().change_scene_to_file("res://order.tscn")

func change_to_roll() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")

func change_to_cook() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")

func change_to_curry() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")



func _on_ready() -> void:
	pass
	
func _process(delta: float):
	
	if (globalData.viewingTicket != null and ticketSpawned == false):
		var instance_data = globalData.viewingTicket
		var instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		viewingTicketNode = instance
		globalData.viewingTicket = instance_data
		globalData.ticketOccupied = true
		fallingCurry.visible = false
		ticketSpawned = true
	
	# check if space bar pressed and there is a collision
	if (globalData.viewingTicket != null and currySelected == true):
		if (Input.is_action_just_pressed("ui_accept")):
			
			# check if they chose right curry
			if (curryChosen == globalData.viewingTicket["curry"]):
				globalData.score += 100
			else:
				globalData.score += 0
			
			spacePressed = true
			if (is_colliding_green):
				print("green")
				globalData.score += 100
			elif (is_colliding_yellow):
				print("yellow")
				globalData.score += 50
			else:
				print("red")
				globalData.score += 0
			globalData.ladleMoving = false
			fallingCurry.position.x = ladle.position.x
			fallingCurry.position.y = ladle.position.y
			fallingCurry.visible = true
			print("fallingCurry visible")
			
	if (globalData.viewingTicket != null and curryFalling == true and fallingCurry.position.y < targetCurryY):
		fallingCurry.position.y += 10
		
	if (globalData.viewingTicket != null and currySelected == true and spacePressed == false):
		globalData.ladleMoving = true
	else:
		globalData.ladleMoving = false


func _on_green_body_entered(body: Node2D) -> void:
	is_colliding_green = true

func _on_green_body_exited(body: Node2D) -> void:
	is_colliding_green = false


func _on_finish_order_button_pressed() -> void:
	if (globalData.viewingTicket != null):
		globalData.orderFinished = true
		globalData.viewingTicket = null
		globalData.ticketOccupied = false
		globalData.canTakeOrder = true	
		globalData.makeNewTicket()
		globalData.totalScore += globalData.score
		get_tree().change_scene_to_file("res://order.tscn")


func _on_red_body_entered(body: Node2D) -> void:
	is_colliding_red = true


func _on_red_body_exited(body: Node2D) -> void:
	is_colliding_red = false


func _on_yellow_body_entered(body: Node2D) -> void:
	is_colliding_yellow = true


func _on_yellow_body_exited(body: Node2D) -> void:
	is_colliding_yellow = false

func _on_paneer_button_pressed() -> void:
	currySelected = true
	curryChosen = "Paneer"
	animationPlayer.play("paneer")


func _on_butter_chicken_button_pressed() -> void:
	currySelected = true
	curryChosen = "Butter Chicken"
	animationPlayer.play("butterChicken")


func _on_gobi_button_pressed() -> void:
	currySelected = true
	curryChosen = "Gobi"
	animationPlayer.play("gobi")
