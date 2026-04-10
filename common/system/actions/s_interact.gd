class_name InteractionSystem
extends System

func query():
	return q.with_all([C_Input, C_PhysicsBody])
func process(entities: Array[Entity], _components: Array, _delta: float) -> void:
	var all_entities = ECS.world.entities

	for player in entities:
		var input = player.get_component(C_Input) as C_Input
		if not input or not input.interact:
			continue

		var closest = _find_closest_interactable(player.get_component(C_PhysicsBody).body, all_entities)
		if closest and closest != player:
			_handle_interaction(player, closest)
	
func _find_closest_interactable(player_body: PhysicsBody2D, entities: Array) -> Entity:
	var closest: Entity = null
	var min_dist := INF
	
	for e in entities:
		var interact = e.get_component(C_Interactable) as C_Interactable
		if interact and interact.interact_area:
			if interact.interact_area.overlaps_body(player_body):
				var dist = player_body.global_position.distance_to(
					interact.interact_area.global_position
				)
				if dist < min_dist:
					min_dist = dist
					closest = e
	
	return closest
func _handle_interaction(player: Entity, target: Entity):
	var _cmd = InteractCommand.new()
	_cmd.execute(player, target)
