extends Sprite2D

@onready var rollToCookHolder = get_node("/root/MainScene/roll/Roll->Cook")
@onready var rawRotiCookHold = get_node("/root/MainScene/cook/RawRotiHolder")
@onready var cookHoldPos = rawRotiCookHold.global_position

var mouseEnt = 0
var mouseEx = 0

func _process(delta: float):
	if Input.is_action_just_pressed("click"):
		if(mouseEnt - 1 == mouseEx):
			rollToCookHolder.rotiOccupied.global_position = cookHoldPos
			rollToCookHolder.isOccupied = false
			rollToCookHolder.rotiOccupied = null
			scale = Vector2(1, 1)
	
func _on_area_2d_mouse_entered() -> void:
	mouseEnt += 1
	if rollToCookHolder.isOccupied:
		scale = Vector2(1.05, 1.05)
		

func _on_area_2d_mouse_exited():
	mouseEx += 1
	if rollToCookHolder.isOccupied:
		scale = Vector2(1, 1)
