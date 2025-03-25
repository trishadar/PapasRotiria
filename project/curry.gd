extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var is_colliding: bool = false

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
	
func _process(delta: float):
	# check if space bar pressed and there is a collision
	if (Input.is_action_just_pressed("ui_accept")):
		if (is_colliding):
			print("yes")
			globalData.ladleMoving = false
		else:
			print("no")
			globalData.ladleMoving = false


func _on_green_body_entered(body: Node2D) -> void:
	is_colliding = true

func _on_green_body_exited(body: Node2D) -> void:
	is_colliding = false
