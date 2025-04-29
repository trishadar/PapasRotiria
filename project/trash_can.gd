extends Node2D

@onready var trashHold = get_node("PutRotiHereTrash")
@onready var ms = get_node("/root/MainScene")
@onready var curry = get_node("/root/MainScene/curry")

func _process(delta: float) -> void:
	if(trashHold.isOccupied):
		if(ms.rotiList.has(trashHold.rotiOccupied)):
			ms.rotiList.erase(trashHold.rotiOccupied)
			ms.remove_child(trashHold.rotiOccupied)
		else:
			curry.remove_child(trashHold.rotiOccupied)
			var newBowl = curry.bowl_scene.instantiate()
			curry.add_child(newBowl)
			newBowl.global_position = curry.bowlPos
			curry.bowl = newBowl
			curry.bowlPlayer = newBowl.get_node("AnimationPlayer")
			curry.bowlPlayer.play("emptyBowl")
			
			curry.curryDropped = false
			curry.curryChosen = null
			curry.spacePressed = false
			curry.currySelected = false
		
		trashHold.rotiOccupied = null
		trashHold.isOccupied = false
		
