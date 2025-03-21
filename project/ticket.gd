extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time
@onready var randomNum = -1
var dragging = false
var offset = Vector2()
var size: Vector2 = Vector2(220, 330)  # Define a default size (width, height)


func _on_ready() -> void:
	visible = false
	ticketNumber.text = str(globalData.ticketNum)
	randomNum = randi() %3
	dough.text = str(globalData.doughs[randomNum])
	randomNum = randi() %3
	curry.text = str(globalData.curries[randomNum])
	randomNum = randi() %3
	time.text = str(globalData.times[randomNum])
	
	set_process_input(true)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_mouse_over(get_global_mouse_position()):
				dragging = true
				offset = position - get_global_mouse_position()
			else:
				dragging = false
				
	if dragging and event is InputEventMouseMotion:
		position = get_global_mouse_position() + offset
		
func is_mouse_over(mouse_position: Vector2) -> bool:
	var global_rect = Rect2(position - (size / 2), size)
	return global_rect.has_point(mouse_position)
