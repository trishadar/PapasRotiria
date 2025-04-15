extends Node2D

@onready var trashHold = get_node("PutRotiHereTrash")
@onready var ms = get_node("/root/MainScene")

func _process(delta: float) -> void:
	if(trashHold.isOccupied):
		ms.rotiList.erase(trashHold.rotiOccupied)
		ms.remove_child(trashHold.rotiOccupied)
		
		trashHold.rotiOccupied = null
		trashHold.isOccupied = false
		
