extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time
@onready var randomNum = -1
var dragging = false
var offset = Vector2()


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
			if event.pressed and is_mouse_over(event.position):
				dragging = true
				offset = position - event.position
			else:
				dragging = false
				
	if dragging and event is InputEventMouseMotion:
		position = event.position + offset
		
func is_mouse_over(mouse_position: Vector2) -> bool:
	var global_rect = Rect2(global_position - (get_size() / 2), get_size())
	return global_rect.has_point(mouse_position)
