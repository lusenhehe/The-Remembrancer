class_name MovementSystem
extends System

func query() -> QueryBuilder:
	return q.with_all([C_PhysicsBody, C_Velocity, C_Input]).iterate([C_PhysicsBody, C_Velocity, C_Input])

func process(entities: Array[Entity], components: Array, _delta: float) -> void:
	var bodies = components[0]
	var velocities = components[1]
	var inputs = components[2]
	for i in range(entities.size()):
		var body = bodies[i].body
		var inp = inputs[i]
		var dir = Vector2(int(inp.right) - int(inp.left), int(inp.down) - int(inp.up)).normalized()
		body.velocity = dir * velocities[i].speed
		body.move_and_slide()
