class_name HealthSystem
extends System

# 查询条件：拥有 C_Health 组件的所有实体
func query() -> QueryBuilder:
    return q.with_all([C_Health])


# 处理逻辑：遍历符合条件的实体
func process(entities: Array[Entity], _components: Array, _delta: float) -> void:
    for entity in entities:
        var health = entity.get_component(C_Health) as C_Health
        if health.current <= 0.0:
            print("实体死亡：", entity.name)
    ## 调试： 按下空格键时，减少所有实体的生命值
    if Input.is_key_pressed(KEY_SPACE):
        for entity in entities:
            var health = entity.get_component(C_Health) as C_Health
            health.current -= 10.0