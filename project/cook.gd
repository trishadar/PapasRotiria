extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var ticketSpawned = false
var instance = null
var ticketDeleted = false

@onready var pan = get_node("PutRotiHere")
@onready var pan2 = get_node("PutRotiHere2")
@onready var trash = get_node("PutRotiHereTrash")

@onready var ms = get_node("/root/MainScene")

func _process(delta: float):
	if (globalData.viewingTicket != null and ticketSpawned == false and globalData.currentScene == "cook" and globalData.orderFinished == false):
		var instance_data = globalData.viewingTicket
		instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		viewingTicketNode = instance
		globalData.viewingTicket = instance_data
		globalData.ticketOccupied = true
		ticketSpawned = true
		ticketDeleted = false
		
	if (globalData.orderFinished == true):
		ticketSpawned = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		instance.queue_free()
		ticketDeleted = true
	
	for rotiObj in ms.rotiList:
		if((rotiObj.global_position == pan.global_position || rotiObj.global_position == pan2.global_position)):
			startCooking(rotiObj)
		elif((rotiObj.global_position == trash.global_position)):
			print_debug("debra")
			ms.rotiList.erase(rotiObj)
			ms.remove_child(rotiObj)
		else:
			stopCooking(rotiObj)

func startCooking(roti):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	if(rotiAnim.frame != 31):
		rotiAnim.play()

func stopCooking(roti):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	rotiAnim.pause()

func _on_ready() -> void:
	pass
		
