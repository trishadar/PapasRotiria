extends Node2D

@onready var rotiHold = get_node("PutRotiHere")
@onready var bowlHold = get_node("PutBowlHere")
@onready var bowlHold2 = get_node("PutBowlHere2")

@onready var sidebar = get_node("/root/MainScene/sidebar")

var rollScore = 0
var cookScore = 0
var curryScore = 0

func calculateScore():
	if(rotiHold.isOccupied):
		var roti = rotiHold.rotiOccupied
		
		if(roti.isRoti && sidebar.viewingTicketNode.dough.text == "Roti"):
			rollScore += 100
			
		
		if(roti.isNaan && sidebar.viewingTicketNode.dough.text == "Naan"):
			rollScore += 100
		
		cookScore += int(250 - abs(float(sidebar.viewingTicketNode.timeNum) - rad_to_deg(roti.cookHandRot)))
	
	if(bowlHold.isOccupied):
		var bowl = bowlHold.rotiOccupied
		if(bowl.whichCurry == sidebar.viewingTicketNode.curry.text):
			curryScore += 50
		if(bowl.whichColor == "green"):
			curryScore += 100
		if(bowl.whichColor == "yellow"):
			curryScore += 50
	
	if(bowlHold2.isOccupied):
		var bowl = bowlHold2.rotiOccupied
		if(bowl.whichCurry == sidebar.viewingTicketNode.curry.text):
			curryScore += 50
		if(bowl.whichColor == "green"):
			curryScore += 100
		if(bowl.whichColor == "yellow"):
			curryScore += 50

	
	globalData.totalScore += rollScore + cookScore + curryScore
