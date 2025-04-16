extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time

var dragging = false
var initial_mouse_position: Vector2
var initial_position: Vector2
var initial_scale
var scale_factor: float = 0.35
var hasShrunk = false
var side_box_position: Vector2 = Vector2(1011, 318)
var thisTicketOccupied = true  # Initialized to true since it starts in the side box
var thisTicketStored = false  # Initialized to false

func _ready() -> void:
	ticketNumber.text = "ticketNumber"
	dough.text = "dough"
	curry.text = "curry"
	time.text = "time"
	position = side_box_position
	z_index = 10
	visible = true
	initial_scale = scale
	set_process_input(true)

func set_up(data):
	ticketNumber.text = data.get("ticketNumber", "N/A")
	dough.text = data.get("dough", "N/A")
	curry.text = data.get("curry", "N/A")
	time.text = data.get("time", "N/A")
	position = data.get("position", side_box_position)
	scale = Vector2(1, 1) if position == side_box_position else Vector2(scale_factor, scale_factor)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_mouse_over(get_global_mouse_position()):
				if (thisTicketOccupied or thisTicketStored):
					# Only shrink if it's currently occupied
					if (thisTicketStored == true and thisTicketOccupied == false):
						print("moved ticket to side")
						move_to_side_box()  # Move to side box
					elif (thisTicketStored == false and thisTicketOccupied == true):
						print("moved ticket to top")
						move_to_top()  # Move to top
					else:
						print("thisTicketStored and thisTicketOccupied are false")

func is_mouse_over(mouse_position: Vector2) -> bool:
	return get_global_rect().has_point(mouse_position)

func get_global_rect() -> Rect2:
	var shape = get_node("Area2D/CollisionShape2D").shape
	if shape is RectangleShape2D:
		var rect = shape.size
		return Rect2(global_position - rect / 2, rect)
	return Rect2()

func move_to_side_box() -> void:
	if globalData.viewingTicket != null:
		position = side_box_position
		scale = Vector2(1, 1)
		hasShrunk = false
		thisTicketOccupied = true
		thisTicketStored = false
		globalData.ticketOccupied = true
		globalData.viewingTicket["position"] = side_box_position
		
		var ticket_data = {
		"ticketNumber": ticketNumber.text,
		"dough": dough.text,
		"curry": curry.text,
		"time": time.text,
		"position": side_box_position
	}
		globalData.viewingTicket = ticket_data

func move_to_top() -> void:
	if globalData.viewingTicket != null:
		var xPos = getStoragePos()
		if xPos != null:
			position.x = xPos
			position.y = 65
			scale = Vector2(.35, .35)
			hasShrunk = true
			thisTicketOccupied = false
			thisTicketStored = true
			globalData.ticketOccupied = false
			# globalData.viewingTicket["position"] = Vector2(position.x, position.y)
			globalData.viewingTicket = null
		
func getStoragePos():
	var foundSpot = false
	var spot = null
	for i in range(globalData.storage.size()):
		if (foundSpot == false and globalData.storage[i] == 0):
			foundSpot = true
			spot = i
			
	if foundSpot == false:
		#storage is full
		return null
	else:
		var pos = (spot+1) * 100
		globalData.storage[spot] = 1
		return pos
