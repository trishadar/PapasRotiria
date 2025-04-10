extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time

var dragging = false
var initial_mouse_position: Vector2
var initial_scale: Vector2
var scale_factor: float = 0.35  # Factor by which the scene will shrink
var sizeX = 220
var sizeY = 330
var hasShrunk = false
var side_box_position: Vector2 = Vector2(1011, 318)
var thisTicketOccupied = false
var thisTicketStored = false


func _on_ready() -> void:
	ticketNumber.text = "ticketNumber"
	dough.text = "dough"
	curry.text = "curry"
	time.text = "time"
	position = Vector2(1011, 318)
	z_index = 10
	visible = true
	initial_scale = scale
	set_process_input(true)

func set_up(data):
	ticketNumber.text = data.get("ticketNumber", "N/A")
	dough.text = data.get("dough", "N/A")
	curry.text = data.get("curry", "N/A")
	time.text = data.get("time", "N/A")
	position = data.get("position", "N/A")
	if (position == Vector2(1011, 318)):
		scale = Vector2(1,1)
		# print("grow ticket")
	else:
		scale = Vector2(.35,.35)
		# print("shrink ticket")
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# print("event.pressed: " , event.pressed)
			# print("thisTickedOccupied: " , thisTicketOccupied)
			# print("thisTicketStored: " , thisTicketStored)
			# print("is_mouse_over(get_global_mouse_position(): " , is_mouse_over(get_global_mouse_position()))
			if event.pressed and (thisTicketOccupied == true or thisTicketStored == true) and is_mouse_over(get_global_mouse_position()):
				# print("dragging ticket")
				dragging = true
				initial_mouse_position = get_global_mouse_position()
				
				if (thisTicketOccupied == true):
					shrink_scene()
				globalData.ticketOccupied = false
				thisTicketOccupied = false
				thisTicketStored = false
			else:
				dragging = false
				if (position.x >= 750):
					move_to_side_box()
					globalData.ticketOccupied = true
					thisTicketOccupied = true
					thisTicketStored = false
				else:
					move_to_top()
					thisTicketOccupied = false
					thisTicketStored = true
				
	if dragging and event is InputEventMouseMotion:
		var delta = get_global_mouse_position() - initial_mouse_position
		position += delta  # Update position based on mouse movement
		initial_mouse_position = get_global_mouse_position()
		
func is_mouse_over(mouse_position: Vector2) -> bool:
	var global_rect = Rect2(position - (get_rect_size() / 2), get_rect_size())
	return global_rect.has_point(mouse_position)

func get_rect_size() -> Vector2:
	return Vector2(sizeX, sizeY)

func shrink_scene() -> void:
	if (hasShrunk == false and thisTicketOccupied == true):
		scale *= scale_factor  # Shrink the scene by the defined scale factor
		sizeX = scale_factor * 220
		sizeY = scale_factor * 330
		hasShrunk = true
		
func move_to_side_box() -> void:
	if (globalData.viewingTicket != null):
		position = side_box_position
		scale = Vector2(1,1)
		sizeX = 220
		sizeY = 330
		hasShrunk = false
		globalData.viewingTicket["position"] = Vector2(1011, 318)
	
func move_to_top() -> void:
	if (globalData.viewingTicket != null):
		position.y = 65
		globalData.viewingTicket["position"] = Vector2(position.x, position.y)
