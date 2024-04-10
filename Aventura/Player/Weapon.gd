extends Node2D
 
@onready var sword = $Sword

func _ready():
	sword.disable()

func enable():
	if !sword:return
	visible = true
	sword.enable()

func disable():
	if !sword:return
	visible = false
	sword.disable()



