extends Resource

class_name Inventory

signal updated
@export var slots: Array[InventorySlot]

#Estudiar
func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			if slot.amount >= slot.item.stackSize:continue
			slot.amount += 1 
			updated.emit()
			return
#Estudiar
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			return
#Estudiar
func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	

func insertSlot(index:int,invetorySlot:InventorySlot):
	var oldIndex = slots.find(invetorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = invetorySlot
	
	
	

