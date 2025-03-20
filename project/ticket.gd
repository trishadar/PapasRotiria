extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time
@onready var randomNum = -1


func _on_ready() -> void:
	ticketNumber.text = str(globalData.ticketNum)
	randomNum = randi() %3
	dough.text = str(globalData.doughs[randomNum])
	randomNum = randi() %3
	curry.text = str(globalData.curries[randomNum])
	randomNum = randi() %3
	time.text = str(globalData.times[randomNum])
	
