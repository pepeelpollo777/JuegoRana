extends Button

@onready var backgroundSprite: Sprite2D =  $Bg
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Inventory/PlayerInvertory.tres") 

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1
	container.add_child(itemStackGui)
	#Estudiar
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)


#Estudiar
func takeItem():
	var item =itemStackGui
	
	container.remove_child(itemStackGui)
	itemStackGui = null 
	backgroundSprite.frame = 0
	
	return item

func isEmpty():
	return !itemStackGui



