extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var ticketSpawned = false
var instance = null
var ticketDeleted = false
var ticketPosUpdated = false

@onready var pan = get_node("PutRotiHere")
@onready var pan2 = get_node("PutRotiHere2")
@onready var trash = get_node("PutRotiHereTrash")

@onready var ms = get_node("/root/MainScene")
@onready var sidebar = $sidebar

@onready var timerHand = get_node("CookTimer/TimerHand")
@onready var timerHand2 = get_node("CookTimer2/TimerHand")


func _process(delta: float):
	
	if (globalData.viewingTicket != null and ticketSpawned == false and globalData.currentScene == "cook" and globalData.orderFinished == false):
		sidebar.spawn_scene()
		ticketSpawned = true
		ticketDeleted = false
		
	if (globalData.viewingTicket != null and ticketSpawned == true and globalData.currentScene != "cook"):
		sidebar.update_ticket()
		
	if (globalData.orderFinished == true):
		ticketSpawned = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		sidebar.remove_scene()
		ticketDeleted = true
	
	for rotiObj in ms.rotiList:
		if(rotiObj.global_position == pan.global_position && !rotiObj.isCooking):
			startCooking(rotiObj, timerHand)
		elif(rotiObj.global_position == pan2.global_position && !rotiObj.isCooking):
			startCooking(rotiObj, timerHand2)
		elif((rotiObj.global_position == trash.global_position)):
			print_debug("debra")
			ms.rotiList.erase(rotiObj)
			ms.remove_child(rotiObj)
		elif(rotiObj.isCooking && (rotiObj.global_position != pan.global_position && rotiObj.global_position != pan2.global_position)):
			stopCooking(rotiObj)

func startCooking(roti, whichHand):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	rotiAnim.animation = "cook"
	if(rotiAnim.frame != 31):
		rotiAnim.play()
		roti.isCooking = true
		whichHand.rotation = roti.cookHandRot
			
		roti.timeStart = Time.get_ticks_msec()
			
		if(roti.cookTween == null || roti.whichHand != whichHand):
			print("Creating tween")
			roti.cookTween = get_tree().create_tween()
			roti.cookTween.tween_property(whichHand, "rotation", deg_to_rad(360), 31 - (roti.cookTime/1000))
			roti.whichHand = whichHand
		else:
			roti.cookTween.play()

func stopCooking(roti):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	rotiAnim.pause()
	roti.isCooking = false
	print("Stop Timer")
	roti.cookTween.pause()
	
	roti.timeNow = Time.get_ticks_msec()
	roti.cookTime += roti.timeNow - roti.timeStart
	
	roti.cookHandRot = roti.whichHand.rotation

func _on_ready() -> void:
	pass
		
