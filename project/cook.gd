extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null

func _process(delta: float):
	var rotiObj = get_node("Roti")
	var pan = get_node("PutRotiHere")
	var pan2 = get_node("PutRotiHere2")
	var rotiAnim = get_node("Roti/AnimatedSprite2D")
	if((rotiObj.position == pan.position || rotiObj.position == pan2.position) && rotiAnim.frame != 20):
		rotiAnim.play()
	else:
		rotiAnim.pause();

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
