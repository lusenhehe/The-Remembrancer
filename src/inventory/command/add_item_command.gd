class_name AddItemCommand
extends InventoryCommand

var item_id: String
var amount: int = 1
var properties: Dictionary = {}

func execute(entity: Entity) -> void:
	var inv: C_Inventory = entity.get_component(C_Inventory)

	inv.inventory.add(item_id, amount, properties)