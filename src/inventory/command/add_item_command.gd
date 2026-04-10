class_name AddItemCommand
extends InventoryCommand

var item_id: String
var amount: int = 1
var properties: Dictionary = {}

func execute(c_inventory: C_Inventory) -> void:
	c_inventory.inventory.add(item_id, amount, properties) 
