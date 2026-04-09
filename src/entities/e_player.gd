@tool
class_name PlayerEntity
extends Entity

@export var hurtbox: Area2D
@export var cam: Camera2D
@export_group("PlayerEntity_Components")
@export_subgroup("C_Velocity")
@export var speed: float = 200.0
@export_subgroup("C_PhysicsBody")
@export var characterbody: CharacterBody2D
@export_subgroup("C_Inventory")
@export var inventory: GridInventory
@export var inventory_panel: GridInventoryPanel
func define_components() -> Array:
	return [
		C_PhysicsBody.new(),
		C_Velocity.new(),
		C_Input.new(),
		C_Health.new(),

		## 物品相关组件
		C_Inventory.new(),
		C_InventoryCommandQueue.new(),
	]
 
func on_ready() -> void:
	# 配置速度
	var c_velocity = get_component(C_Velocity) as C_Velocity
	c_velocity.speed = speed

	# 绑定 CharacterBody2D 到物理组件
	var c_phys = get_component(C_PhysicsBody) as C_PhysicsBody
	c_phys.body = characterbody
	hurtbox.connect("body_entered", Callable(self, "_on_hurtbox_body_entered"))

	# 初始化健康值（调试用）
	var hp = get_component(C_Health) as C_Health
	hp.current = hp.maximum

	# # 设置
	var view = get_component(C_Inventory) as C_Inventory 
	view.inventory = inventory
	view.inventory_panel = inventory_panel

func _on_hurtbox_body_entered(_body: Node) -> void:
	var hp = get_component(C_Health) as C_Health
	if hp:
		hp.current -= 10.0
