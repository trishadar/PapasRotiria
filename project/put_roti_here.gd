extends StaticBody2D

var isOccupied = false
var rotiOccupied

var isBowl = false
var isTrash = false

func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	
	if(is_in_group("BowlDroppable") && is_in_group("Droppable")):
		isTrash = true
	elif(is_in_group("BowlDroppable")):
		isBowl = true

func _process(delta):
	if (((globalData.is_bowl_dragging && isBowl) || (globalData.is_roti_dragging && !isBowl)) && !isOccupied) || ((globalData.is_bowl_dragging || globalData.is_roti_dragging) && isTrash):
		visible = true
	else:
		visible = false
	
	if(rotiOccupied != null):
		if(rotiOccupied.global_position != global_position):
			isOccupied = false
		if(rotiOccupied.global_position == global_position):
			isOccupied = true
	
	if(isOccupied && isBowl):
		self.remove_from_group("BowlDroppable")
	if(isOccupied && !isBowl):
		self.remove_from_group("Droppable")
	else:
		if(isBowl):
			self.add_to_group("BowlDroppable")
		else:
			self.add_to_group("Droppable")

func newRoti(roti):
	rotiOccupied = roti
