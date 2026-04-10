class_name ChestUISystem
extends System

func query():
	return q.with_all([C_ChestState, C_Inventory, C_Interactable])

func process(entities: Array, _components: Array, _delta: float) -> void:
	for e in entities:
		var chest_state = e.get_component(C_ChestState) as C_ChestState
		var inv = e.get_component(C_Inventory) as C_Inventory
		var interact = e.get_component(C_Interactable) as C_Interactable

		inv.inventory_panel.visible = chest_state.is_open
		interact.target_node.visible = not chest_state.is_open
