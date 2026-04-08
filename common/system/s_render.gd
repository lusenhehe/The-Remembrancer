class_name RenderSystem
extends System

func query() -> QueryBuilder:
    return q.with_all([C_Transform]).iterate([C_Transform])

func process(entities: Array[Entity], components: Array, _delta: float) -> void:
    var transforms = components[0]
    for i in range(transforms.size()):
        var entity = entities[i]
        var t = transforms[i] as C_Transform
        if entity is Node2D:
            entity.position = t.position
            entity.rotation = t.rotation
