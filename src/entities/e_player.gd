class_name PlayerEntity
extends Entity

@export var characterbody: CharacterBody2D
@export var speed: float = 200.0
@export var hurtbox: Area2D
@export var cam: Camera2D

func define_components() -> Array:
	return [
		C_PhysicsBody.new(),
		C_Velocity.new(),
		C_Input.new(),
		C_Health.new()
	]
 
func on_ready() -> void:
	# 配置速度
	var c_velocity = get_component(C_Velocity) as C_Velocity
	if c_velocity:
		c_velocity.speed = speed

	# 绑定 CharacterBody2D 到物理组件
	var c_phys = get_component(C_PhysicsBody) as C_PhysicsBody
	c_phys.body = characterbody
	if hurtbox.is_connected("body_entered", Callable(self, "_on_hurtbox_body_entered")):
		hurtbox.connect("body_entered", Callable(self, "_on_hurtbox_body_entered"))

	# 初始化健康值（调试用）
	var hp = get_component(C_Health) as C_Health
	if hp and hp.current <= 0:
		hp.current = hp.maximum


func _on_hurtbox_body_entered(_body: Node) -> void:
	var hp = get_component(C_Health) as C_Health
	if hp:
		hp.current -= 10.0
