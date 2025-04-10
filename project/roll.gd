extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var sceneToSpawn = preload("res://roti.tscn")

var spawn_count: int = 0
var ticketSpawned = false
var spawnCountChecker = false

#@onready var dough = get_node("Roti")
@onready var board = get_node("PutRotiHere")
@onready var button = $takeOrderButton

@onready var ms = get_node("/root/MainScene")

var instance = null
var ticketDeleted = false
@onready var sidebar = $sidebar


func _on_take_order_button_pressed() -> void:
	spawn_count = spawn_count+1
	spawn_scene()
	#
	

func spawn_scene():
	var dough = sceneToSpawn.instantiate()
	ms.add_child(dough)
	dough.position = Vector2(1380,400)
	ms.rotiList.append(dough)

	


func _process(delta: float):
	if (globalData.viewingTicket != null and ticketSpawned == false and globalData.currentScene == "roll"):
		sidebar.spawn_scene()
		ticketSpawned = true
		ticketDeleted = false
		
	if (globalData.orderFinished == true):
		ticketSpawned = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		sidebar.remove_scene()
		ticketDeleted = true

		
		
	for rotiObj in ms.rotiList:
		if(rotiObj.position == board.global_position and spawnCountChecker == false):
			print_debug("debra")
			rotiObj.visible = false
			board.isOccupied = false
			board.rotiOccupied = null
			spawn_count = spawn_count - 1
			print_debug(spawn_count)
			spawnCountChecker = true
			
		if spawn_count>=1:
			button.disabled = true
		else:
			button.disabled = false
