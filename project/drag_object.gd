extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos : Vector2

var cookHandRot = 0
var isCooking = false
var cookTween
var whichHand
var cookTime = 0

var timeStart = 0
var timeNow = 0
var isNaan
var isRoti
var roll

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			globalData.is_roti_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			globalData.is_roti_dragging = false
			var tween = get_tree().create_tween()
			tween.connect("finished", _on_tween_finished)
			if is_inside_dropable:
				tween.tween_property(self, "position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	if not globalData.is_roti_dragging && not globalData.is_bowl_dragging:
		draggable = true

func _on_area_2d_mouse_exited():
	if not globalData.is_roti_dragging && not globalData.is_bowl_dragging:
		draggable = false

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('Droppable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('Droppable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _on_tween_finished():
	if(body_ref != null):
		body_ref.isOccupied = true
		body_ref.newRoti(self)
