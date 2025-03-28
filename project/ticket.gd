extends Node2D

@onready var ticketNumber = $ticketNumber
@onready var dough = $dough
@onready var curry = $curry
@onready var time = $time


func _on_ready() -> void:
	ticketNumber.text = "ticketNumber"
	dough.text = "dough"
	curry.text = "curry"
	time.text = "time"
	position = Vector2(1011, 318)
	z_index = 10
	visible = true
	set_process_input(true)

func set_up(data):
	ticketNumber.text = data.get("ticketNumber", "N/A")
	dough.text = data.get("dough", "N/A")
	curry.text = data.get("curry", "N/A")
	time.text = data.get("time", "N/A")
	
