@tool
extends Entity
class_name ChestEntity

@export var inventory: GridInventory
@export var interact_area: Area2D
@export var chest_inventory_panel: GridInventoryPanel

@export var items : Dictionary[String, int]
@export var target_node: Label
func define_components() -> Array:
	var inventory_component = C_Inventory.new()
	inventory_component.inventory = inventory
	inventory_component.inventory_panel = chest_inventory_panel
	var interactable_component = C_Interactable.new()
	interactable_component.interact_type = "chest"
	interactable_component.interact_area = interact_area
	interactable_component.target_node = target_node
	var chest_state = C_ChestState.new() 
	chest_state.is_open = false
	return [inventory_component, interactable_component,C_InventoryCommandQueue.new(), chest_state]

func add_init_items() -> void:
	for item_id in items.keys():
		var _cmd = AddItemCommand.new()
		_cmd.item_id = item_id
		_cmd.amount = items[item_id]
		_cmd.execute(self.get_component(C_Inventory))
