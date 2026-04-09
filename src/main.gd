# main.gd
extends Node

@export var world: World
@export var ecs_fps := 60.0
@export var unlimited_fps := false
@export var player: PlayerEntity
@export var training_dummy: TrainingDummy
var _accum := 0.0
var ecs_tick_rate := 1.0 / ecs_fps

func _process(delta):
	if Input.is_action_just_released("attack"):
		_send_attack()

	if unlimited_fps:
		ECS.process(delta)
		return
	else:
		_accum += delta
		
		if _accum < ecs_tick_rate:
			return
		
		ECS.process(_accum)
		_accum = 0.0

func _ready():
	ecs_tick_rate = 1.0 / ecs_fps
	# 绑定世界
	ECS.world = world 
	setup_systems()
	setup_entities()

func setup_systems():
	# 注册系统（攻击反馈 -> 伤害处理 -> 血量检查 -> 其他）
	ECS.world.add_system(HitFeedbackSystem.new())
	ECS.world.add_system(DamageSystem.new())
	ECS.world.add_system(InputSystem.new())
	ECS.world.add_system(HealthSystem.new())
	ECS.world.add_system(MovementSystem.new())
	ECS.world.add_system(RenderSystem.new())
	ECS.world.add_system(InventoryCommandSystem.new())

	ECS.world.finalize_system_setup() 

func setup_entities(): 
	setup_inventory(player)

func setup_inventory(_player):
	# 测试加物品
	var queue = _player.get_component(C_InventoryCommandQueue)
	var cmd = AddItemCommand.new()
	cmd.item_id = "wood"
	cmd.amount = 3 

	queue.commands.append(cmd)
	var new_cmd = AddItemCommand.new() 
	new_cmd.item_id = "helmet_labor"
	new_cmd.amount = 3

	queue.commands.append(new_cmd)

func _send_attack() -> void:
	var dmg = C_Damage.new()
	dmg.amount = 10.0
	dmg.source = player
	training_dummy.add_component(dmg)

	var current_health = training_dummy.get_component(C_Health) as C_Health
	if current_health:
		print("Dummy HP:", current_health.current)
 
