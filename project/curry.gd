extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var is_colliding_green: bool = false
var is_colliding_yellow: bool = false
var is_colliding_red: bool = false
var targetCurryY = 200
@onready var animationPlayer = $fallingCurry/AnimationPlayer
@onready var fallingCurry = $fallingCurry
@onready var ladle = $ladle
var currySelected = false
var spacePressed = false
var curryChosen
var curryDropped = false

@onready var cam = get_node("/root/MainScene/Camera2D")
var orderPos = Vector2(576, 323)
var orderPresentPos = Vector2(5696,323)

var instance = null
var ticketPosUpdated = false
@onready var sidebar = $sidebar
@onready var globalSidebar = get_node("/root/MainScene/sidebar")

@onready var rotiPlate = get_node("Plate/PutRotiHere")
@onready var bowlPlate = get_node("Plate/PutBowlHere")
@onready var bowlPlate2 = get_node("Plate/PutBowlHere2")
@onready var ms = get_node("/root/MainScene")

@onready var bowl = get_node("Bowl")
@onready var bowlPos = bowl.global_position

var bowl_scene: PackedScene = preload("res://bowl.tscn")
var color = null
@onready var bowlPlayer = get_node("Bowl/AnimationPlayer")

@onready var orderPresent = ms.get_node("PresentOrder")

func _on_ready() -> void:
	bowlPlayer.play("emptyBowl")
	
func _process(delta: float):
	
	if (globalData.orderFinished == true):
		curryDropped = false
		curryChosen = null
		spacePressed = false
		currySelected = false
		globalSidebar.remove_scene()
		
	
	# check if space bar pressed and there is a collision
	if (bowl.whichCurry == null and currySelected == true):
		if (Input.is_action_just_pressed("ui_accept") and curryDropped == false):
			curryDropped = true
			
			bowl.whichCurry = curryChosen
			
			spacePressed = true
			if (is_colliding_green):
				print("green")
				color = "green"
				bowl.whichColor = "green"
			elif (is_colliding_yellow):
				print("yellow")
				color = "yellow"
				bowl.whichColor = "yellow"
			else:
				print("red")
				color = "red"
				bowl.whichColor = "red"
			globalData.ladleMoving = false
			fallingCurry.position.x = ladle.position.x
			fallingCurry.position.y = ladle.position.y
			fallingCurry.visible = true
			
	if (fallingCurry.visible && curryDropped == true):
		if (fallingCurry.position.y < targetCurryY):
			fallingCurry.position.y += 10
		elif (fallingCurry.position.y == targetCurryY):
			fallingCurry.visible = false
			
			if (curryChosen == "Paneer" and color != "red"):
				# print("color: " , color)
				bowlPlayer.play("paneerBowl")
			elif (curryChosen == "Gobi" and color != "red"):
				bowlPlayer.play("gobiBowl")
			elif (curryChosen == "Butter Chicken" and color != "red"):
				bowlPlayer.play("butterChickenBowl")
		
	if (bowl.whichCurry == null and currySelected == true and spacePressed == false):
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
		
		var plate = get_node("Plate")
		plate.calculateScore()
		
		cam.position = orderPresentPos
		orderPresent.justOpened()
		globalSidebar.position = globalSidebar.startingPos
		globalData.ticketCount -= 1


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

func clearPlate():
	if(rotiPlate.isOccupied):
		rotiPlate.isOccupied = false
		ms.rotiList.erase(rotiPlate.rotiOccupied)
		ms.remove_child(rotiPlate.rotiOccupied)
		rotiPlate.rotiOccupied = null
	if(bowlPlate.isOccupied):
		bowlPlate.isOccupied = false
		remove_child(bowlPlate.rotiOccupied)
		bowlPlate.rotiOccupied = null
		var newBowl = bowl_scene.instantiate()
		add_child(newBowl)
		newBowl.global_position = bowlPos
		bowl = newBowl
		bowlPlayer = newBowl.get_node("AnimationPlayer")
		bowlPlayer.play("emptyBowl")
	if(bowlPlate2.isOccupied):
		bowlPlate2.isOccupied = false
		remove_child(bowlPlate2.rotiOccupied)
		bowlPlate2.rotiOccupied = null
		var newBowl = bowl_scene.instantiate()
		add_child(newBowl)
		newBowl.global_position = bowlPos
		bowl = newBowl
		bowlPlayer = newBowl.get_node("AnimationPlayer")
		bowlPlayer.play("emptyBowl")
