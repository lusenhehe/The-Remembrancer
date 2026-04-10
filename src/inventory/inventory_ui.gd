extends CanvasLayer
class_name InventoryUI
@export var player_inventory_ui : GridInventoryPanel
@export var chest_inventory_ui : GridInventoryPanel
# 将 player_inventory_ui 与 chest_inventory_ui 的请求信号连接到处理器
func _ready() -> void:
	player_inventory_ui.request_transfer_to.connect(_on_request_transfer_to)
	player_inventory_ui.request_fast_transfer.connect(_on_request_fast_transfer)
	player_inventory_ui.request_split.connect(_on_request_split)

	chest_inventory_ui.request_transfer_to.connect(_on_request_transfer_to)
	chest_inventory_ui.request_fast_transfer.connect(_on_request_fast_transfer)
	chest_inventory_ui.request_split.connect(_on_request_split)
	chest_inventory_ui.connect("close_requested", Callable(self, "_on_panel_closed"))
func _on_request_transfer_to(origin_inventory: GridInventory, origin_pos: Vector2i, destination_inventory: GridInventory, _destination_pos: Vector2i, amount: int, _is_rotated: bool) -> void:
	var dest_inv: GridInventory = destination_inventory
	if dest_inv == null:
		if player_inventory_ui and chest_inventory_ui:
			if origin_inventory == player_inventory_ui.inventory:
				dest_inv = chest_inventory_ui.inventory
			else:
				dest_inv = player_inventory_ui.inventory
		else:
			return
	origin_inventory.transfer(origin_inventory.get_stack_index_at(origin_pos), dest_inv, amount)
func _on_request_fast_transfer(origin_inventory: GridInventory, origin_pos: Vector2i, amount: int) -> void:
	if origin_inventory == null:
		return

	var dest_inv: GridInventory = null
	if player_inventory_ui and chest_inventory_ui:
		if origin_inventory == player_inventory_ui.inventory:
			dest_inv = chest_inventory_ui.inventory
		else:
			dest_inv = player_inventory_ui.inventory
	if dest_inv == null:
		return

	origin_inventory.transfer(origin_inventory.get_stack_index_at(origin_pos), dest_inv, amount)
func _on_request_split(inventory: Inventory, stack_index: int, amount: int) -> void:

	if inventory.has_method("split"):
		inventory.split(stack_index, amount)
	else:
		push_warning("No split handler available for inventory")
func _on_panel_closed() -> void:
	var entities = ECS.world.entities
	for e in entities:
		var chest_state = e.get_component(C_ChestState) as C_ChestState
		var inv = e.get_component(C_Inventory) as C_Inventory
		if chest_state and inv.inventory_panel == chest_inventory_ui:
			chest_state.is_open = false
			return
