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
var sizeX = 220
var sizeY = 330
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
			print("event.pressed: ", event.pressed)
			if event.pressed and is_mouse_over(get_global_mouse_position()):
				print("thisTickedOccupied: ", thisTicketOccupied)
				print("thisTicketStored: ", thisTicketStored)
				if dragging == false and (thisTicketOccupied or thisTicketStored):
					dragging = true
					initial_mouse_position = get_global_mouse_position()
					initial_position = position
					
					# Only shrink if it's currently occupied
					if thisTicketOccupied:
						shrink_scene()
					
					# Reset globalData.ticketOccupied since we're starting to drag
					globalData.ticketOccupied = false

			elif !event.pressed and dragging:
				dragging = false
				# Check position to determine where to move the ticket
				if position.x >= 750:
					move_to_side_box()  # Move to side box
					thisTicketOccupied = true
					thisTicketStored = false
				else:
					move_to_top()  # Move to top
					thisTicketOccupied = false
					thisTicketStored = true

	if dragging and event is InputEventMouseMotion:
		var delta = get_global_mouse_position() - initial_mouse_position
		position = initial_position + delta  # Update position based on mouse movement

func is_mouse_over(mouse_position: Vector2) -> bool:
	var global_rect = Rect2(position - (get_rect_size() / 2), get_rect_size())
	return global_rect.has_point(mouse_position)

func get_rect_size() -> Vector2:
	return Vector2(sizeX, sizeY)

func shrink_scene() -> void:
	if not hasShrunk and thisTicketOccupied:
		scale *= scale_factor
		sizeX = scale_factor * 220
		sizeY = scale_factor * 330
		hasShrunk = true

func move_to_side_box() -> void:
	if globalData.viewingTicket != null:
		position = side_box_position
		scale = Vector2(1, 1)
		sizeX = 220
		sizeY = 330
		hasShrunk = false
		globalData.viewingTicket["position"] = side_box_position

func move_to_top() -> void:
	if globalData.viewingTicket != null:
		position.y = 65
		globalData.viewingTicket["position"] = Vector2(position.x, position.y)
