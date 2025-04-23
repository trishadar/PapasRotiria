extends Sprite2D

@onready var rollToCookHolder = get_node("/root/MainScene/roll/Roll->Cook")
@onready var cookToCurryHolder = get_node("/root/MainScene/cook/Cook->Curry")
@onready var rawRotiCookHold = get_node("/root/MainScene/cook/RawRotiHolder/PutRotiHere")
@onready var cookedCurryHold = get_node("/root/MainScene/curry/Plate/PutRotiHere")

@onready var whichScene
@onready var useThisHolder
@onready var goesToHold

var mouseEnt = 0
var mouseEx = 0

func _process(delta: float):
	if useThisHolder.isOccupied:
		if Input.is_action_just_pressed("click") && isFullRolled():
			if(mouseEnt - 1 == mouseEx):
				if(goesToHold.isOccupied):
					print("Transfer is occupied")
				else:
					useThisHolder.rotiOccupied.global_position = goesToHold.global_position
					goesToHold.isOccupied = true
					goesToHold.rotiOccupied = useThisHolder.rotiOccupied
					
					useThisHolder.isOccupied = false
					useThisHolder.rotiOccupied = null
					
					scale = Vector2(1, 1)
	
func _on_area_2d_mouse_entered() -> void:
	mouseEnt += 1
	if useThisHolder != null && useThisHolder.isOccupied && isFullRolled():
		scale = Vector2(1.05, 1.05)
		

func _on_area_2d_mouse_exited():
	mouseEx += 1
	if useThisHolder != null && useThisHolder.isOccupied && isFullRolled():
		scale = Vector2(1, 1)

func isFullRolled():
	var rotiAnim = useThisHolder.rotiOccupied.get_node("AnimatedSprite2D")
	if rotiAnim.animation == "roll" && rotiAnim.frame == 12:
		return true
	elif rotiAnim.animation == "cook":
		return true
	else:
		false

func _ready():
	var pos = self.global_position
	if(pos.x >= 1280 && pos.x <= 2450):
		whichScene = "roll"
		useThisHolder = rollToCookHolder
		goesToHold = rawRotiCookHold
	if(pos.x >= 2560 && pos.x <= 3730):
		whichScene = "cook"
		useThisHolder = cookToCurryHolder
		goesToHold = cookedCurryHold
