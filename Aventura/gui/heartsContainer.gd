extends HBoxContainer

@onready var HeartGuiClass = preload("res://gui/heart_gui.tscn")


func setMaxHearts(max: float):
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: float):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
	
	for i in range(currentHealth,hearts.size()):
		hearts[i].update(false)
