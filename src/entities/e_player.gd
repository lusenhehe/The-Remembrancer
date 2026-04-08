## PlayerSystem.gd
## 玩家实体类，继承自 Entity 基类
class_name Player
extends Entity

# 定义该实体拥有的组件
func define_components() -> Array:
	return [C_Health.new(100), C_Velocity.new()]


func on_ready(): 
	# 只有场景根节点是 Node3D/Node2D 时才能使用坐标、变换等空间属性
	var c_vel = get_component(C_Velocity) as C_Velocity
	if c_vel:
		c_vel.direction = Vector2.RIGHT 
