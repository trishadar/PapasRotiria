extends Node2D

@onready var ms = get_node("/root/MainScene")
@onready var cam = ms.get_node("Camera2D")
@onready var curry = ms.get_node("curry")
@onready var plate = curry.get_node("Plate")
@onready var ticket_scene: PackedScene = preload("res://ticket.tscn")
@onready var customer_scene: PackedScene = preload("res://customer.tscn")

var orderPos = Vector2(576, 323)
@onready var platePosCurry = plate.global_position
var platePosPresent = Vector2(4416 + 1500, 323)
var customerPos = Vector2(5616, 300)

var instance = null
var customerInst

func _on_go_back_button_pressed() -> void:
	cam.global_position = orderPos
	globalData.currentScene = "order"
	plate.global_position = platePosCurry
	globalData.orderFinished = false
	
	remove_child(customerInst)
	customerInst = null
	remove_child(instance)
	instance = null
	
	curry.clearPlate()

func justOpened():
	
	instance = ticket_scene.instantiate()
	add_child(instance)
	instance.set_up(globalData.recentTicket)
	
	customerInst = customer_scene.instantiate()
	add_child(customerInst)
	customerInst.global_position = customerPos
	var animationPlayer = customerInst.get_node("AnimationPlayer")
	
	if(globalData.viewingTicketNode.custType == "rithika"):
		animationPlayer.play("rithika")
	elif(globalData.viewingTicketNode.custType == "kyle"):
		animationPlayer.play("kyle")
	
	var rotiHold = plate.get_node("PutRotiHere")
	var isRoti = false
	var bowlHold = plate.get_node("PutBowlHere")
	var isBowl
	var bowlHold2 = plate.get_node("PutBowlHere2")
	var isBowl2
	
	if(rotiHold.isOccupied):
		isRoti = true
	if(bowlHold.isOccupied):
		isBowl = true
	if(bowlHold2.isOccupied):
		isBowl2 = true
	
	plate.global_position = platePosPresent
	if(isRoti):
		rotiHold.rotiOccupied.global_position = rotiHold.global_position 
	if(isBowl):
		bowlHold.rotiOccupied.global_position = bowlHold.global_position
	if(isBowl2):
		bowlHold2.rotiOccupied.global_position = bowlHold2.global_position
