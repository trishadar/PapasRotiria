extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var sceneToSpawn = preload("res://roti.tscn")

var spawn_count: int = 0
var ticketSpawned = false

func change_to_order() -> void:
	get_tree().change_scene_to_file("res://order.tscn")

func change_to_roll() -> void:
	get_tree().change_scene_to_file("res://roll.tscn")

func change_to_cook() -> void:
	get_tree().change_scene_to_file("res://cook.tscn")

func change_to_curry() -> void:
	get_tree().change_scene_to_file("res://curry.tscn")

func _on_take_order_button_pressed() -> void:
	spawn_scene()
	#
	

func spawn_scene():
	var instance = sceneToSpawn.instantiate()
	add_child(instance)
	instance.position = Vector2(100,400)
	
	#figure out how to spawn in only one ball of dough at a time (check how many rotis are in scene?)
	#figure out how to move roti from one scene to next
	#figure out how to connect order ticket to roti to verify if the final order attached to the ticket is correct
	
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
		ticketSpawned = true
