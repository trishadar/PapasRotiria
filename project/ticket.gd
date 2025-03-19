extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time


func _on_ready() -> void:
	ticketNumber.text = str(globalData.ticketNum)
	dough.text = str(globalData.doughs[0])
	curry.text = str(globalData.curries[0])
	time.text = str(globalData.times[0])
	
