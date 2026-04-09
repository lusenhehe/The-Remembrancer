class_name HitFeedbackSystem
extends System

func query():
    return q.with_all([C_View, C_HitFeedback]).iterate([C_View, C_HitFeedback])

func process(entities, components, delta):
    var views = components[0]
    var feedbacks = components[1]

    for i in entities.size():
        var entity = entities[i]
        var view = views[i]
        var fb = feedbacks[i]

        if not is_instance_valid(view.node):
            continue

        var sprite = view.node.get_node_or_null("Sprite2D")
        if sprite: 
            sprite.modulate = Color(1, 0.6, 0.6)

        fb.duration -= delta

        if fb.duration <= 0:
            if sprite:
                sprite.modulate = Color(1,1,1)

            cmd.remove_component(entity, C_HitFeedback)
