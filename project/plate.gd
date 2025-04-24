extends Node2D

@onready var rotiHold = get_node("PutRotiHere")
@onready var bowlHold = get_node("PutBowlHere")
@onready var bowlHold2 = get_node("PutBowlHere2")

@onready var sidebar = get_node("/root/MainScene/sidebar")

func calculateScore():
	if(rotiHold.isOccupied):
		var roti = rotiHold.rotiOccupied
		print(float(sidebar.viewingTicketNode.timeNum) , " - " , rad_to_deg(roti.cookHandRot))
		
		print(250 - abs((float(sidebar.viewingTicketNode.timeNum) - rad_to_deg(roti.cookHandRot))))
		globalData.score += int(250 - abs(float(sidebar.viewingTicketNode.timeNum) - rad_to_deg(roti.cookHandRot)))
	
	if(bowlHold.isOccupied):
		var bowl = bowlHold.rotiOccupied
		if(bowl.whichCurry == sidebar.viewingTicketNode.curry.text):
			globalData.score += 50
			print(50)
		
		if(bowl.whichColor == "green"):
			globalData.score += 100
			print(100)
		if(bowl.whichColor == "yellow"):
			globalData.score += 50
			print(50)
	
	if(bowlHold2.isOccupied):
		var bowl = bowlHold2.rotiOccupied
		if(bowl.whichCurry == sidebar.viewingTicketNode.curry.text):
			globalData.score += 50
			print(50)
		
		if(bowl.whichColor == "green"):
			globalData.score += 100
			print(100)
		if(bowl.whichColor == "yellow"):
			globalData.score += 50
			print(50)
	
	globalData.totalScore += globalData.score
