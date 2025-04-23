extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var is_colliding_green: bool = false
var is_colliding_yellow: bool = false
var is_colliding_red: bool = false
var curryFalling = true
var targetCurryY = 200
@onready var animationPlayer = $fallingCurry/AnimationPlayer
@onready var fallingCurry = $fallingCurry
@onready var ladle = $ladle
var currySelected = false
var spacePressed = false
var curryChosen
var ticketSpawned = false
var curryDropped = false

@onready var cam = get_node("/root/MainScene/Camera2D")
var orderPos = Vector2(576, 323)

var instance = null
var ticketDeleted = false
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

func _on_ready() -> void:
	pass
	
func _process(delta: float):
	
	if (globalData.viewingTicket != null and ticketSpawned == false and globalData.currentScene == "curry" and globalData.orderFinished == false):
		sidebar.initial_spawn_scene()
		fallingCurry.visible = false
		ticketSpawned = true
		ticketDeleted = false
		
	if (globalData.orderFinished == true):
		ticketSpawned = false
		curryDropped = false
		curryChosen = null
		spacePressed = false
		currySelected = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		sidebar.remove_scene()
		ticketDeleted = true
		
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
			ms.add_child(newBowl)
			newBowl.global_position = bowlPos
			bowl = newBowl
		if(bowlPlate2.isOccupied):
			bowlPlate2.isOccupied = false
			remove_child(bowlPlate2.rotiOccupied)
			bowlPlate2.rotiOccupied = null
			var newBowl = bowl_scene.instantiate()
			ms.add_child(newBowl)
			newBowl.global_position = bowlPos
			bowl = newBowl
		
	
	# check if space bar pressed and there is a collision
	if (globalData.viewingTicket != null and currySelected == true):
		if (Input.is_action_just_pressed("ui_accept") and curryDropped == false):
			curryDropped = true
			
			bowl.whichCurry = curryChosen
			
			spacePressed = true
			if (is_colliding_green):
				print("green")
				bowl.whichColor = "green"
			elif (is_colliding_yellow):
				print("yellow")
				bowl.whichColor = "yellow"
			else:
				print("red")
				bowl.whichColor = "yellow"
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
		
		var plate = get_node("Plate")
		plate.calculateScore()
		
		cam.position = orderPos
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
	if (globalData.ticketOccupied == true):
		currySelected = true
		curryChosen = "Paneer"
		animationPlayer.play("paneer")


func _on_butter_chicken_button_pressed() -> void:
	if (globalData.ticketOccupied == true):
		currySelected = true
		curryChosen = "Butter Chicken"
		animationPlayer.play("butterChicken")


func _on_gobi_button_pressed() -> void:
	if (globalData.ticketOccupied == true):
		currySelected = true
		curryChosen = "Gobi"
		animationPlayer.play("gobi")
