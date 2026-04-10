class_name InputSystem
extends System

func query() -> QueryBuilder:
	return q.with_all([C_Input, C_Velocity])


func process(entities: Array[Entity], _components: Array, _delta: float) -> void:
	for entity in entities:
		var c_input = entity.get_component(C_Input) as C_Input
		c_input.up = Input.is_action_pressed("move_up")
		c_input.down = Input.is_action_pressed("move_down")
		c_input.left = Input.is_action_pressed("move_left")
		c_input.right = Input.is_action_pressed("move_right")
		c_input.interact = Input.is_action_just_pressed("interact")
		
		c_input.ui_inventory_visible = Input.is_action_just_released("ui_inventory")

		c_input.ui_open_chest_visible = Input.is_action_just_released("ui_openbox")