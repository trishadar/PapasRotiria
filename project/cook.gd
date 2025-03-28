extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null

@onready var pan = get_node("PutRotiHere")
@onready var pan2 = get_node("PutRotiHere2")
@onready var trash = get_node("PutRotiHereTrash")
@onready var rotiList = [get_node("Roti")]

func _process(delta: float):
	for rotiObj in rotiList:
		if((rotiObj.position == pan.position || rotiObj.position == pan2.position)):
			startCooking(rotiObj)
		elif((rotiObj.position == trash.position)):
			remove_child(rotiObj)
		else:
			startCooking(rotiObj)

func startCooking(roti):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	if(rotiAnim.frame != 31):
		rotiAnim.play()

func stopCooking(roti):
	var rotiAnim = roti.get_node("AnimatedSprite2D")
	rotiAnim.pause()

func change_to_order() -> void:
	get_tree().change_scene_to_file("res://order.tscn")

func change_to_roll() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")

func change_to_cook() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")

func change_to_curry() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")

func _on_ready() -> void:
	if (globalData.viewingTicket != null):
		var instance_data = globalData.viewingTicket
		var instance = ticket_scene.instantiate()
		add_child(instance)
		instance.set_up(instance_data)
		viewingTicketNode = instance
		globalData.viewingTicket = instance_data
		globalData.ticketOccupied = true
		
