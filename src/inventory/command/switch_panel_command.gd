class_name SwitchPanelCommand
extends InventoryCommand

var item_id: String = ""

func execute(c_inventory: C_Inventory) -> void:
	c_inventory.inventory_panel.visible = not c_inventory.inventory_panel.visible
