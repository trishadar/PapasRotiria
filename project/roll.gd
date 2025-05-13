extends Node2D

var ticket_scene: PackedScene = preload("res://ticket.tscn")
var viewingTicketNode = null
var sceneToSpawn = preload("res://roti.tscn")

var spawn_count: int = 0
var ticketSpawned = false
var spawnCountChecker = false
var spacebar = false
var isTweening = false

#@onready var dough = get_node("Roti")
@onready var board = get_node("PutRotiHere")
@onready var spawn = get_node("PutRotiHere2")
@onready var button = $takeOrderButton
@onready var pin = get_node("RollingPin")

@onready var ms = get_node("/root/MainScene")

var rotispawn = false
var naanspawn = false

var instance = null
var ticketDeleted = false
@onready var sidebar = $sidebar
#var pinYPosition = pin.position.y

func _on_take_order_button_pressed() -> void:
	spawn_count = spawn_count+1
	spawn_scene()
	#
	

func spawn_scene():
	var dough = sceneToSpawn.instantiate()
	dough.scale = Vector2(1.5, 1.5)
	dough.roll = true
	var costume = dough.get_node("AnimatedSprite2D")
	if rotispawn:
		costume.animation = "roti roll"
		dough.isRoti = true
	if naanspawn:
		costume.animation = "naan roll"
		dough.isNaan = true
	ms.add_child(dough)
	dough.global_position = spawn.global_position
	spawn.isOccupied = true
	spawn.rotiOccupied = dough
	ms.rotiList.append(dough)

	


func _process(delta: float):
	
	if(spawn.isOccupied == true):
		button.disabled = true
	else:
		button.disabled = false
	if(!rotispawn and !naanspawn):
		button.disabled = true

		
		
	for rotiObj in ms.rotiList:
		if board.isOccupied == false:
			$Control/ProgressBar.value = 0
		if(rotiObj.position == board.global_position and spawnCountChecker == false):
			board.isOccupied = false
			board.rotiOccupied = null
			spawnCountChecker = true
			
			
		if(spawnCountChecker == true and rotiObj.position == board.global_position):
			var doughtoroti = rotiObj.get_node("AnimatedSprite2D")
			$Control/ProgressBar.value = doughtoroti.frame*8.33
			if(Input.is_action_just_pressed("ui_right") and doughtoroti.frame!=12 and isTweening == false):
				doughtoroti.frame = doughtoroti.frame+1
				var tween = get_tree().create_tween()
				tween.connect("finished",_on_tween_finished)
				tween.tween_property(pin, "global_position", pin.global_position-Vector2(0,-250), 0.2)
				isTweening = true
			if(doughtoroti.frame == 12 and rotiObj.position != board.global_position):
				rotiObj.roll = false
				
		if(spawn.isOccupied == true):
			button.disabled = true
		else:
			button.disabled = false
func _on_tween_finished():
	var tween = get_tree().create_tween()
	tween.connect("finished",_on_tween_finished_finished)
	tween.tween_property(pin, "global_position", pin.global_position-Vector2(0,250), 0.2)
	
func _on_tween_finished_finished():
	isTweening = false


func _on_spawn_roti_pressed() -> void:
	rotispawn = true
	naanspawn = false


func _on_spawn_naan_pressed() -> void:
	rotispawn = false
	naanspawn = true
