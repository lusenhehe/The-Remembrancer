class_name InputSystem
extends System

func query() -> QueryBuilder:
    return q.with_all([C_Input, C_Velocity])

func process(entities: Array[Entity], components: Array, delta: float) -> void:
    for entity in entities:
        var c_input = entity.get_component(C_Input) as C_Input
        var c_velocity = entity.get_component(C_Velocity) as C_Velocity
        c_input.up = Input.is_action_pressed("move_up")
        c_input.down = Input.is_action_pressed("move_down")
        c_input.left = Input.is_action_pressed("move_left")
        c_input.right = Input.is_action_pressed("move_right")
        var dir = Vector2(int(c_input.right) - int(c_input.left), int(c_input.down) - int(c_input.up))
        if dir.length() > 0:
            c_velocity.direction = dir.normalized()
        else:
            c_velocity.direction = Vector2.ZERO
 