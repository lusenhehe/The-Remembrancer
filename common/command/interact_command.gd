class_name InteractCommand
extends Resource

func execute(_player: Entity, target: Entity = null) -> void:
	var interact = target.get_component(C_Interactable) as C_Interactable

	match interact.interact_type:
		"chest": 
			_toggle_chest(target)
		"npc":
			# Add NPC interaction logic here (e.g., dialogue state change)
			pass
		"loot":
			# Add loot pickup logic here (e.g., add item state)
			pass

func _toggle_chest(target: Entity) -> void:
	var chest_state = target.get_component(C_ChestState) as C_ChestState
	if chest_state == null:
		return

	chest_state.is_open = not chest_state.is_open
