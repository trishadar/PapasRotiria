extends StaticBody2D

var isOccupied = false
var rotiOccupied

func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _process(delta):
	if globalData.is_dragging:
		visible = true
	else:
		visible = false
	
	if(rotiOccupied != null):
		if(rotiOccupied.position != position):
			isOccupied = false
			
	if(isOccupied):
		self.remove_from_group("Droppable")
	else:
		self.add_to_group("Droppable")

func newRoti(roti):
	rotiOccupied = roti
