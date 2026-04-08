class_name MovementSystem
extends System

func query() -> QueryBuilder:
    return q.with_all([C_Transform, C_Velocity]).iterate([C_Transform, C_Velocity])

func process(entities: Array[Entity], components: Array, delta: float) -> void:
    var transforms = components[0]
    var velocities = components[1]
    for i in range(transforms.size()):
        transforms[i].position += velocities[i].direction * velocities[i].speed * delta
 