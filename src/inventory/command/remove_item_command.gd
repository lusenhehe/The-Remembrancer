class_name RemoveItemCommand
extends InventoryCommand

var item_id: String = ""

func execute(c_inventory: C_Inventory) -> void:
    c_inventory.inventory.remove(item_id)
