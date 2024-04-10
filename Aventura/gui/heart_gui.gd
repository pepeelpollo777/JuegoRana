extends Panel

@onready var heart =  $Sprite2D

func update(hole:bool):
	if hole: heart.frame = 0
	else: heart.frame = 4 

