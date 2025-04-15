extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var sceneToSpawn = preload("res://roti.tscn")

var spawn_count: int = 0
var ticketSpawned = false
var spawnCountChecker = false
var spacebar = false
#@onready var dough = get_node("Roti")
@onready var board = get_node("PutRotiHere")
@onready var spawn = get_node("PutRotiHere2")
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
	dough.global_position = spawn.global_position
<<<<<<< HEAD
=======
	spawn.isOccupied = true
	spawn.rotiOccupied = dough
>>>>>>> 01a73d45c2bac6db692b6c4bd0b329219d7bb76b
	ms.rotiList.append(dough)

	


func _process(delta: float):
	if (globalData.viewingTicket != null and ticketSpawned == false and globalData.currentScene == "roll"):
		sidebar.spawn_scene()
		ticketSpawned = true
		ticketDeleted = false
		
	if (globalData.viewingTicket != null and ticketSpawned == true and globalData.currentScene != "roll"):
		sidebar.update_ticket()
		
	if (globalData.orderFinished == true):
		ticketSpawned = false
		
	if (globalData.orderFinished == true and ticketDeleted == false):
		sidebar.remove_scene()
		ticketDeleted = true
		
	if(spawn.isOccupied == true):
		button.disabled = true
	else:
		button.disabled = false

		
		
	for rotiObj in ms.rotiList:
		
		if(rotiObj.position == board.global_position and spawnCountChecker == false):
			#spawn.isOccupied = false
			print_debug("debra")
			#rotiObj.visible = false
			board.isOccupied = false
			board.rotiOccupied = null
			spawnCountChecker = true
			
		if(spawnCountChecker == true and rotiObj.position == board.global_position):
			var doughtoroti = rotiObj.get_node("AnimatedSprite2D")
			if(Input.is_action_just_pressed("ui_right") and doughtoroti.frame!=12):
				doughtoroti.frame = doughtoroti.frame+1
			
		if(spawn.isOccupied == true):
			button.disabled = true
		else:
			button.disabled = false
