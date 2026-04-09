class_name RemoveItemCommand
extends InventoryCommand

var item_id: String = ""

func execute(entity: Entity) -> void:
    var inv: C_Inventory = entity.get_component(C_Inventory)


    inv.inventory.remove(item_id)
