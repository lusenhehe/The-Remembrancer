class_name HealthSystem
extends System

# 查询条件：拥有 C_Health 组件的所有实体
func query() -> QueryBuilder:
	return q.with_all([C_Health])

# 处理逻辑：遍历符合条件的实体
func process(_entities: Array[Entity], _components: Array, _delta: float) -> void:
	pass